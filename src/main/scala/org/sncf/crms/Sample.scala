package org.sncf.crms
import org.apache.log4j.Logger
import com.typesafe.config.ConfigFactory
import org.apache.spark.sql.SQLContext
import org.apache.spark.{SparkConf, SparkContext}

object Sample extends App {

  val logger: Logger = Logger.getLogger(this.getClass.getName)
  val environement= args(0)
  val config = ConfigFactory.load(environement)

  val env = config.getString("env")

  val conf = new SparkConf().setAppName(config.getString("spark.app.name"))

  logger.info("ENVIRONNEMENT: "+env)
  logger.info("APP NAME: "+config.getString("spark.app.name"))
  logger.info("DRIVER MEMORY: "+config.getString("spark.driver.memory"))
  logger.info("EXECUTOR MEMORY: "+config.getString("spark.executor.memory"))

  val sc = new SparkContext(conf)
  val sqlContext = new SQLContext(sc)

  val rdd = sc.textFile(config.getString("file_path"))
  val df = sqlContext.read.json(rdd)
  df.show

  sc.stop()


}
