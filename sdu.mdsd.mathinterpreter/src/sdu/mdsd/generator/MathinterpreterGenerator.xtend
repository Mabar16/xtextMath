/*
 * generated by Xtext 2.17.1
 */
package sdu.mdsd.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import sdu.mdsd.mathinterpreter.MathExp
import sdu.mdsd.mathinterpreter.Exp
import sdu.mdsd.mathinterpreter.Plus
import sdu.mdsd.mathinterpreter.Minus
import sdu.mdsd.mathinterpreter.Mult
import sdu.mdsd.mathinterpreter.Div
import sdu.mdsd.mathinterpreter.Primary
import sdu.mdsd.mathinterpreter.Parenthesis
import sdu.mdsd.mathinterpreter.Number
import sdu.mdsd.mathinterpreter.Variable

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class MathinterpreterGenerator extends AbstractGenerator {
	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		val exps = resource.allContents.filter(MathExp).toList
		for	(exp : exps){
			System.out.println(exp.displayMath)
		}
	}
	
	def int compute(MathExp math) { 
		math.getExp().computeExp
	}
	
	def dispatch int computeExp(Exp exp) {
		val left = exp.left.computeExp
		switch exp.operator {
			Plus: left+exp.right.computeExp
			Minus: left-exp.right.computeExp
			Mult: left*exp.right.computeExp
			Div: left/exp.right.computeExp
			default: left
		}
	}
	
	def dispatch int computeExp(Number num){
		num.getValue()
	}
	def dispatch int computeExp(Parenthesis par){
		computeExp(par.getExp())
	}
	def dispatch int computeExp(Primary prim){
		prim.computeExp()
	}
	
	def dispatch CharSequence displayMath(Variable vari){
		'''«vari.getName()» = [«vari.getExp().displayExp»]'''	
	}
	
	def dispatch CharSequence displayMath(MathExp math){ 
			'''Evaluation = [«math.exp.displayExp»]'''
	}
	
	def dispatch CharSequence displayExp(Exp exp){'''Exp[«exp.left?.displayExp»] Op[«exp.operator?.displayOp»] Exp[«exp.right?.displayExp»]'''}
	def dispatch String displayOp(Plus op)  { "+" }
	def dispatch String displayOp(Minus op) { "-" }
	def dispatch String displayOp(Mult op) { "*" }
	def dispatch String displayOp(Div op) { "/" }
	def dispatch CharSequence displayExp(Primary prim) {'''«prim.displayExp()»'''}
	def dispatch CharSequence displayExp(Parenthesis par) {'''Paren[«displayExp(par.getExp())»]'''}
	def dispatch CharSequence displayExp(Number num) {'''«num.getValue()»'''}
	

}
