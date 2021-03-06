CREATE OR REPLACE PACKAGE pk_Payroll_Processing AUTHID DEFINER AS
  /**
  * It processes the employees' monthly payroll.
  *
  * @param pPayrollMonth indicates which month should be calculated
  */
  PROCEDURE pr_Calculate_month_payroll(pPayrollMonth IN DATE);
END pk_Payroll_Processing;

