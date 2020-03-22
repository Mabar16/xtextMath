package sdu.mdsd.ui

import javax.inject.Inject
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.util.Diagnostician
import sdu.mdsd.generator.MathinterpreterGenerator

import static extension org.eclipse.emf.ecore.util.EcoreUtil.*
import org.eclipse.xtext.ui.editor.hover.html.DefaultEObjectHoverProvider
import sdu.mdsd.mathinterpreter.MathExp
import sdu.mdsd.mathinterpreter.Evaluation
import sdu.mdsd.mathinterpreter.Variable

class ExpEObjectHoverProvider extends DefaultEObjectHoverProvider {

@Inject extension MathinterpreterGenerator


	override getHoverInfoAsHtml(EObject o) {
	if (o instanceof Evaluation && o.programHasNoError) { val math = o as Evaluation
	return '''
			<p>
			 <br> value : <b>«math.compute.toString»</b> 
			 </p>'''
	} else if  (o instanceof Variable && o.programHasNoError) { val _var = o as Variable
	return '''
			<p>
			 <br> «_var.getName()» = <b>«_var.compute.toString»</b> 
			 </p>'''
	}
	else
	return super.getHoverInfoAsHtml(o)
	}

	def programHasNoError(EObject o) { Diagnostician.INSTANCE.validate(o.rootContainer).
		children.empty }
	}
