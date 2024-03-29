USE [SAMU]
GO
/****** Object:  StoredProcedure [dbo].[pa_loguear]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_loguear]
	@usuario as varchar(50),
	@contrasenha as varchar(50),
	@logueado int output,
	@mensaje as varchar(100) output

AS
BEGIN
	 select @logueado= count(usuario)
	 from usuarios
	 where usuario=@usuario and contrasenha=@contrasenha
	 
	 if(@logueado>0)
	 begin
			select @mensaje = 'BIENVENIDO ' + CAST(usuario AS VARCHAR(50)) 
			from usuarios
			where usuario=@usuario and contrasenha=@contrasenha
	 end
	 else
		begin
			select @mensaje = 'EL USUARIO ' + CAST(@usuario as varchar(50)) + ' no existe en la BD'
		end
END

GO
/****** Object: StoredProcedure [dbo].[r_lista_usuarios]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE  [dbo].[r_lista_usuarios]
AS
BEGIN
	select * from usuarios
END

GO
/****** Object:  StoredProcedure [dbo].[s_alta_tipo_documento]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[s_alta_tipo_documento]
	@descripcion as varchar(50)
AS
BEGIN
	
	insert into s_tipo_documento values (@descripcion)

END

GO
/****** Object:  Table [dbo].[c_categoria]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_categoria](
	[cod_categoria] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_categoria] [varchar](20) NULL,
 CONSTRAINT [PK_c_categoria] PRIMARY KEY CLUSTERED 
(
	[cod_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_categoria_tarifa]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[c_categoria_tarifa](
	[cod_categoria_tarifa] [int] IDENTITY(1,1) NOT NULL,
	[cod_categoria] [int] NOT NULL,
	[tarifa_m3_minimo] [numeric](14, 2) NOT NULL,
	[m3_minimo] [numeric](14, 2) NOT NULL,
	[tarifa_m3_excedente] [numeric](14, 2) NULL,
	[m3_excedente] [numeric](14, 2) NULL,
	[vigencia_desde] [datetime] NOT NULL,
	[vigencia_hasta] [datetime] NULL,
	[nro_acta] [numeric](10, 0) NULL,
 CONSTRAINT [PK_c_categoria_tarifa] PRIMARY KEY CLUSTERED 
(
	[cod_categoria_tarifa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[c_conexion]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_conexion](
	[cod_conexion] [int] IDENTITY(1,1) NOT NULL,
	[cod_contrato] [int] NOT NULL,
	[cod_estado] [char](1) NOT NULL,
	[cantidad_reconexion] [int] NULL,
	[tiene_medidor] [char](1) NULL,
	[cod_categoria] [int] NOT NULL,
	[cod_zona] [int] NOT NULL,
	[fecha_conexion] [datetime] NULL,
	[nro_cta_ctral] [varchar](20) NOT NULL,
 CONSTRAINT [PK_c_conexion] PRIMARY KEY CLUSTERED 
(
	[cod_conexion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_contrato]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[c_contrato](
	[cod_contrato] [int] IDENTITY(1,1) NOT NULL,
	[cod_conexion] [int] NOT NULL,
	[cod_socio] [int] NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[fecha_fin] [datetime] NULL,
	[monto_conexion] [numeric](14, 2) NULL,
 CONSTRAINT [PK_c_contrato] PRIMARY KEY CLUSTERED 
(
	[cod_contrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[c_estado_civil]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_estado_civil](
	[cod_ec] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_ec] [varchar](20) NULL,
 CONSTRAINT [PK_c_estado_civil] PRIMARY KEY CLUSTERED 
(
	[cod_ec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_estado_conexion]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_estado_conexion](
	[cod_estado] [char](1) NOT NULL,
	[descripcion_tipo_estado] [varchar](50) NULL,
 CONSTRAINT [PK_c_estado_conexion] PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_estado_lectura]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_estado_lectura](
	[cod_estado] [char](1) NOT NULL,
	[descripcion_tipo_estado] [varchar](50) NULL,
 CONSTRAINT [PK_c_estado_lectura] PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_estado_medidor]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_estado_medidor](
	[cod_estado] [char](1) NOT NULL,
	[descripcion_tipo_estado] [varchar](50) NULL,
 CONSTRAINT [PK_c_estado_medidor] PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_medidor]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_medidor](
	[cod_medidor] [int] NOT NULL,
	[nro_serie] [varchar](20) NOT NULL,
	[estado_medidor] [char](1) NOT NULL,
	[marca] [varchar](20) NULL,
	[ultima_lectura] [numeric](14, 2) NULL,
	[estado_conexion] [char](1) NULL,
 CONSTRAINT [PK_c_medidor] PRIMARY KEY CLUSTERED 
(
	[cod_medidor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_medidor_lectura]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_medidor_lectura](
	[cod_lectura] [int] IDENTITY(1,1) NOT NULL,
	[cod_medidor] [int] NOT NULL,
	[fecha_lectura] [datetime] NULL,
	[lectura_anterior] [numeric](14, 2) NOT NULL,
	[lectura_actual] [numeric](14, 2) NULL,
	[lectura_consumo] [numeric](14, 2) NULL,
	[cod_estado] [char](1) NOT NULL,
 CONSTRAINT [PK_c_medidor_lectura] PRIMARY KEY CLUSTERED 
(
	[cod_lectura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_modifica_lectura]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_modifica_lectura](
	[cod_mod_lectura] [int] IDENTITY(1,1) NOT NULL,
	[cod_lectura] [int] NOT NULL,
	[lectura_actual] [numeric](14, 2) NOT NULL,
	[lectura_modificada] [numeric](14, 2) NOT NULL,
	[fecha_lectura] [numeric](14, 2) NOT NULL,
	[motivo_mod] [varchar](200) NULL,
	[fecha_insert] [datetime] NOT NULL,
	[usuario_insert] [char](4) NOT NULL,
	[fecha_update] [datetime] NULL,
	[usuario_udpate] [char](4) NULL,
 CONSTRAINT [PK_c_modifica_lectura] PRIMARY KEY CLUSTERED 
(
	[cod_mod_lectura] ASC,
	[fecha_lectura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_situacion_conexion]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_situacion_conexion](
	[cod_situacion] [int] NOT NULL,
	[cod_conexion] [int] NOT NULL,
	[cod_estado] [char](1) NOT NULL,
	[fecha] [datetime] NULL,
	[observacion] [varchar](200) NULL,
 CONSTRAINT [PK_c_situacion_conexion] PRIMARY KEY CLUSTERED 
(
	[cod_situacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_socio]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_socio](
	[cod_socio] [int] NOT NULL,
	[cod_tipo_documento] [int] NOT NULL,
	[nro_documento] [numeric](18, 0) NOT NULL,
	[p_nombre] [varchar](20) NOT NULL,
	[s_nombre] [varchar](20) NULL,
	[p_apellido] [varchar](20) NOT NULL,
	[s_apellido] [varchar](20) NULL,
	[c_apellido] [varchar](20) NULL,
	[telefono] [varchar](20) NULL,
	[celular] [varchar](20) NULL,
	[direccion] [varchar](50) NULL,
	[sexo] [char](1) NOT NULL,
	[cod_ec] [int] NOT NULL,
	[fecha_nacimiento] [datetime] NULL,
	[estado_socio] [char](1) NOT NULL,
 CONSTRAINT [pk_c_socio] PRIMARY KEY CLUSTERED 
(
	[cod_socio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[c_zona]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[c_zona](
	[cod_zona] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_zona] [varchar](20) NULL,
 CONSTRAINT [PK_c_zona] PRIMARY KEY CLUSTERED 
(
	[cod_zona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_cobranza]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_cobranza](
	[nro_cobranza] [int] IDENTITY(1,1) NOT NULL,
	[id_fact] [int] NOT NULL,
	[monto] [numeric](14, 2) NOT NULL,
	[fecha_cobranza] [datetime] NOT NULL,
	[cod_estado] [char](1) NOT NULL,
	[motivo_anulacion] [varchar](200) NULL,
	[fecha_anulado] [datetime] NULL,
 CONSTRAINT [PK_f_cobranza] PRIMARY KEY CLUSTERED 
(
	[nro_cobranza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_consumo_x_socio]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[f_consumo_x_socio](
	[cod_consumo] [int] IDENTITY(1,1) NOT NULL,
	[id_fact] [int] NOT NULL,
	[monto_minimo] [numeric](14, 2) NOT NULL,
	[monto_excedente] [numeric](14, 2) NULL,
	[monto_errsan] [numeric](14, 2) NULL,
 CONSTRAINT [PK_f_consumo_x_socio] PRIMARY KEY CLUSTERED 
(
	[cod_consumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[f_cuenta_especial_cabecera]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_cuenta_especial_cabecera](
	[cod_cuenta_especial] [int] NOT NULL,
	[cod_conexion] [int] NOT NULL,
	[cod_tarifa_especial] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[monto_total] [numeric](14, 2) NOT NULL,
	[cantidad_cuotas] [int] NOT NULL,
	[fecha_primer_vto] [datetime] NULL,
	[cancelado] [char](1) NOT NULL,
 CONSTRAINT [PK_f_cuenta_especial_cabecera] PRIMARY KEY CLUSTERED 
(
	[cod_cuenta_especial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_cuenta_especial_cuota]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_cuenta_especial_cuota](
	[cod_cuota_cta_especial] [int] IDENTITY(1,1) NOT NULL,
	[cod_tarifa_especial] [int] NOT NULL,
	[monto_cuota] [numeric](14, 2) NOT NULL,
	[vencimiento] [datetime] NOT NULL,
	[cod_estado] [char](1) NOT NULL,
 CONSTRAINT [PK_f_cuenta_especial_cuota] PRIMARY KEY CLUSTERED 
(
	[cod_cuota_cta_especial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_estado_cobranza]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_estado_cobranza](
	[cod_estado] [char](1) NOT NULL,
	[descripcion_tipo_estado] [varchar](50) NULL,
 CONSTRAINT [PK_f_estado_cobranza] PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_estado_cuenta_especial]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_estado_cuenta_especial](
	[cod_estado] [char](1) NOT NULL,
	[descripcion_tipo_estado] [varchar](50) NULL,
 CONSTRAINT [PK_f_estado_cuenta_especial] PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_estado_factura]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_estado_factura](
	[cod_estado] [char](1) NOT NULL,
	[descripcion_tipo_estado] [varchar](50) NULL,
 CONSTRAINT [PK_f_estado_factura] PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_estado_nota_credito]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_estado_nota_credito](
	[cod_estado] [char](1) NOT NULL,
	[descripcion_tipo_estado] [varchar](50) NULL,
 CONSTRAINT [PK_f_estado_nota_credito] PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_fact_numeracion]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[f_fact_numeracion](
	[id_numeracion] [int] IDENTITY(1,1) NOT NULL,
	[factura_inicio] [int] NOT NULL,
	[factura_fin] [int] NOT NULL,
	[factura_actual] [int] NOT NULL,
 CONSTRAINT [PK_f_fact_numeracion] PRIMARY KEY CLUSTERED 
(
	[id_numeracion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[f_factura]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_factura](
	[id_fact] [int] IDENTITY(1,1) NOT NULL,
	[nro_factura] [int] NOT NULL,
	[fecha_factura] [datetime] NOT NULL,
	[cod_tipo_factura] [char](2) NOT NULL,
	[cod_conexion] [int] NOT NULL,
	[cod_estado] [char](1) NOT NULL,
	[motivo_anulacion] [varchar](200) NULL,
	[monto_total] [numeric](14, 2) NOT NULL,
	[fecha_vencimiento] [datetime] NOT NULL,
	[saldo] [numeric](14, 2) NOT NULL,
	[fecha_anulacion] [datetime] NULL,
 CONSTRAINT [PK_f_factura] PRIMARY KEY CLUSTERED 
(
	[id_fact] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_factura_detalle]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[f_factura_detalle](
	[cod_factura_detalle] [int] IDENTITY(1,1) NOT NULL,
	[id_fact] [int] NOT NULL,
	[monto_detalle] [numeric](14, 2) NOT NULL,
 CONSTRAINT [PK_f_factura_detalle] PRIMARY KEY CLUSTERED 
(
	[cod_factura_detalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[f_nota_credito]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_nota_credito](
	[cod_nota_credito] [int] NOT NULL,
	[id_fact] [int] NOT NULL,
	[cod_conexion] [int] NOT NULL,
	[fecha_emision] [datetime] NOT NULL,
	[cod_estado] [char](1) NOT NULL,
	[monto] [numeric](14, 2) NOT NULL,
	[razon_modificacion] [varchar](200) NULL,
 CONSTRAINT [PK_f_nota_credito] PRIMARY KEY CLUSTERED 
(
	[cod_nota_credito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_tarifa_especial]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_tarifa_especial](
	[cod_tarifa_especial] [int] IDENTITY(1,1) NOT NULL,
	[concepto_tarifa_especial] [varchar](50) NULL,
	[monto_tarifa_especial] [numeric](14, 2) NOT NULL,
 CONSTRAINT [PK_f_tarifa_especial] PRIMARY KEY CLUSTERED 
(
	[cod_tarifa_especial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[f_tipo_factura]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[f_tipo_factura](
	[cod_tipo_factura] [char](2) NOT NULL,
	[descripcion_tipo_factura] [varchar](20) NULL,
 CONSTRAINT [PK_f_tipo_factura] PRIMARY KEY CLUSTERED 
(
	[cod_tipo_factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[o_orden_servicio]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[o_orden_servicio](
	[cod_orden_servicio] [int] IDENTITY(1,1) NOT NULL,
	[cod_tipo_orden] [int] NOT NULL,
	[cod_conexion] [int] NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[fecha_fin] [datetime] NULL,
	[estado_o_servicio] [char](1) NOT NULL,
 CONSTRAINT [PK_o_orden_servicio] PRIMARY KEY CLUSTERED 
(
	[cod_orden_servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[o_orden_servicio_detalle]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[o_orden_servicio_detalle](
	[cod_det_orden_servicio] [int] IDENTITY(1,1) NOT NULL,
	[cod_orden_servicio] [int] NOT NULL,
	[tiene_medidor] [char](1) NOT NULL,
	[cod_medidor] [int] NULL,
	[ultima_lectura] [numeric](14, 2) NULL,
	[observacion] [varchar](200) NULL,
 CONSTRAINT [PK_o_orden_servicio_detalle] PRIMARY KEY CLUSTERED 
(
	[cod_det_orden_servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[o_tipo_orden_servicio]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[o_tipo_orden_servicio](
	[cod_tipo_orden] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_tipo_orden] [varchar](50) NULL,
 CONSTRAINT [PK_o_tipo_orden_servicio] PRIMARY KEY CLUSTERED 
(
	[cod_tipo_orden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_acta]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[s_acta](
	[cod_acta] [int] IDENTITY(1,1) NOT NULL,
	[nro_acta] [numeric](10, 0) NOT NULL,
	[fecha_acta] [datetime] NOT NULL,
	[nro_resolucion] [numeric](10, 0) NULL,
	[cod_mandato] [int] NOT NULL,
 CONSTRAINT [PK_s_acta] PRIMARY KEY CLUSTERED 
(
	[cod_acta] ASC,
	[nro_acta] ASC,
	[fecha_acta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[s_mandato]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_mandato](
	[cod_mandato] [int] IDENTITY(1,1) NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[fecha_fin] [datetime] NULL,
	[presidente] [varchar](200) NULL,
 CONSTRAINT [PK_s_mandato] PRIMARY KEY CLUSTERED 
(
	[cod_mandato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_motivo_desconexion]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_motivo_desconexion](
	[cod_motivo_desconexion] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_mot_descononexion] [varchar](200) NOT NULL,
 CONSTRAINT [PK_s_motivo_desconexion] PRIMARY KEY CLUSTERED 
(
	[cod_motivo_desconexion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_solicitud_cambio_nombre]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_solicitud_cambio_nombre](
	[cod_sol_cambio_nombre] [int] IDENTITY(1,1) NOT NULL,
	[cod_conexion] [int] NOT NULL,
	[fecha_solicitud] [datetime] NOT NULL,
	[p_nombre] [varchar](20) NOT NULL,
	[s_nombre] [varchar](20) NULL,
	[p_apellido] [varchar](20) NOT NULL,
	[s_apellido] [varchar](20) NULL,
	[c_apellido] [varchar](20) NULL,
	[sexo] [char](1) NOT NULL,
	[cod_ec] [int] NOT NULL,
	[fecha_nacimiento] [datetime] NOT NULL,
	[telefono] [varchar](20) NULL,
	[celular] [varchar](20) NULL,
	[direccion] [varchar](50) NULL,
	[cod_estado] [char](1) NOT NULL,
	[nro_habitantes] [numeric](10, 0) NULL,
	[nro_hijos] [numeric](10, 0) NULL,
	[cod_acta] [int] NULL,
	[cod_socio] [int] NULL,
	[usuario_vecino] [varchar](200) NULL,
	[fecha_apro_rech] [datetime] NULL,
	[fecha_insert] [datetime] NOT NULL,
	[usuario_insert] [char](4) NOT NULL,
	[fecha_update] [datetime] NULL,
	[usuario_update] [char](4) NULL,
 CONSTRAINT [PK_cod_sol_cambio_nombre] PRIMARY KEY CLUSTERED 
(
	[cod_sol_cambio_nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_solicitud_conexion]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_solicitud_conexion](
	[cod_solicitud_conexion] [int] IDENTITY(1,1) NOT NULL,
	[nro_cta_ctral] [varchar](20) NOT NULL,
	[fecha_solicitud] [datetime] NOT NULL,
	[p_nombre] [varchar](20) NOT NULL,
	[s_nombre] [varchar](20) NULL,
	[p_apellido] [varchar](20) NOT NULL,
	[s_apellido] [varchar](20) NULL,
	[c_apellido] [varchar](20) NULL,
	[sexo] [char](1) NOT NULL,
	[cod_ec] [int] NOT NULL,
	[fecha_nacimiento] [datetime] NOT NULL,
	[telefono] [varchar](20) NULL,
	[celular] [varchar](20) NULL,
	[direccion] [varchar](50) NULL,
	[cod_tipo_regimen] [int] NOT NULL,
	[cod_estado] [char](1) NOT NULL,
	[nro_habitantes] [numeric](10, 0) NULL,
	[nro_hijos] [numeric](10, 0) NULL,
	[cod_acta] [int] NULL,
	[cod_socio] [int] NULL,
	[usuario_vecino] [varchar](200) NULL,
	[fecha_apro_rech] [datetime] NULL,
	[fecha_insert] [datetime] NOT NULL,
	[usuario_insert] [char](4) NOT NULL,
	[fecha_update] [datetime] NULL,
	[usuario_update] [char](4) NULL,
 CONSTRAINT [PK_cod_solicitud_conexion] PRIMARY KEY CLUSTERED 
(
	[cod_solicitud_conexion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_solicitud_desconexion]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_solicitud_desconexion](
	[cod_sol_desconexion] [int] IDENTITY(1,1) NOT NULL,
	[cod_conexion] [int] NOT NULL,
	[fecha_solicitud] [datetime] NOT NULL,
	[cod_estado] [char](1) NOT NULL,
	[observacion] [varchar](200) NULL,
	[fecha_apro_rech] [datetime] NULL,
	[fecha_insert] [datetime] NOT NULL,
	[usuario_insert] [char](4) NOT NULL,
	[fecha_update] [datetime] NULL,
	[usuario_update] [char](4) NULL,
 CONSTRAINT [PK_cod_sol_desconexion] PRIMARY KEY CLUSTERED 
(
	[cod_sol_desconexion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_tipo_documento]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_tipo_documento](
	[cod_tipo_documento] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_tipo_documento] [varchar](50) NULL,
 CONSTRAINT [PK_s_tipo_documento] PRIMARY KEY CLUSTERED 
(
	[cod_tipo_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_tipo_estado]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_tipo_estado](
	[cod_estado] [char](1) NOT NULL,
	[descripcion_tipo_estado] [varchar](50) NULL,
 CONSTRAINT [PK_s_tipo_estado] PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_tipo_inmueble]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_tipo_inmueble](
	[cod_tipo_inmueble] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_tipo_inmueble] [varchar](50) NULL,
 CONSTRAINT [PK_s_tipo_inmueble] PRIMARY KEY CLUSTERED 
(
	[cod_tipo_inmueble] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_tipo_regimen]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_tipo_regimen](
	[cod_tipo_regimen] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_tipo_regimen] [varchar](50) NULL,
 CONSTRAINT [PK_s_tipo_regimen] PRIMARY KEY CLUSTERED 
(
	[cod_tipo_regimen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_tipo_solicitud]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_tipo_solicitud](
	[cod_tipo_solicitud] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_tipo_solicitud] [varchar](50) NULL,
 CONSTRAINT [PK_s_tipo_solicitud] PRIMARY KEY CLUSTERED 
(
	[cod_tipo_solicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuarios](
	[usuario] [varchar](50) NOT NULL,
	[contrasenha] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vr_lista_usuarios]    Script Date: 09/08/2014 16:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 -- DROP VIEW [Vr_lista_usuarios]
CREATE VIEW  [dbo].[vr_lista_usuarios]
AS

	select * from usuarios


GO
SET IDENTITY_INSERT [dbo].[s_tipo_documento] ON 

INSERT [dbo].[s_tipo_documento] ([cod_tipo_documento], [descripcion_tipo_documento]) VALUES (1, N'Cedula de Identidad')
INSERT [dbo].[s_tipo_documento] ([cod_tipo_documento], [descripcion_tipo_documento]) VALUES (2, N'PASAPORTE')
SET IDENTITY_INSERT [dbo].[s_tipo_documento] OFF
INSERT [dbo].[usuarios] ([usuario], [contrasenha]) VALUES (N'VIVI', N'12345')
INSERT [dbo].[usuarios] ([usuario], [contrasenha]) VALUES (N'RAQUEL', N'12345')
ALTER TABLE [dbo].[c_categoria_tarifa]  WITH CHECK ADD  CONSTRAINT [fk_cod_categoria] FOREIGN KEY([cod_categoria])
REFERENCES [dbo].[c_categoria] ([cod_categoria])
GO
ALTER TABLE [dbo].[c_categoria_tarifa] CHECK CONSTRAINT [fk_cod_categoria]
GO
ALTER TABLE [dbo].[c_conexion]  WITH CHECK ADD  CONSTRAINT [fk_cc_cod_categoria] FOREIGN KEY([cod_categoria])
REFERENCES [dbo].[c_categoria] ([cod_categoria])
GO
ALTER TABLE [dbo].[c_conexion] CHECK CONSTRAINT [fk_cc_cod_categoria]
GO
ALTER TABLE [dbo].[c_conexion]  WITH CHECK ADD  CONSTRAINT [fk_cod_estado_conexion] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[c_estado_conexion] ([cod_estado])
GO
ALTER TABLE [dbo].[c_conexion] CHECK CONSTRAINT [fk_cod_estado_conexion]
GO
ALTER TABLE [dbo].[c_conexion]  WITH CHECK ADD  CONSTRAINT [fk_cod_zona] FOREIGN KEY([cod_zona])
REFERENCES [dbo].[c_zona] ([cod_zona])
GO
ALTER TABLE [dbo].[c_conexion] CHECK CONSTRAINT [fk_cod_zona]
GO
ALTER TABLE [dbo].[c_contrato]  WITH CHECK ADD  CONSTRAINT [fk_cc_cod_conexion] FOREIGN KEY([cod_conexion])
REFERENCES [dbo].[c_conexion] ([cod_conexion])
GO
ALTER TABLE [dbo].[c_contrato] CHECK CONSTRAINT [fk_cc_cod_conexion]
GO
ALTER TABLE [dbo].[c_contrato]  WITH CHECK ADD  CONSTRAINT [fk_cc_cod_socio] FOREIGN KEY([cod_socio])
REFERENCES [dbo].[c_socio] ([cod_socio])
GO
ALTER TABLE [dbo].[c_contrato] CHECK CONSTRAINT [fk_cc_cod_socio]
GO
ALTER TABLE [dbo].[c_medidor]  WITH CHECK ADD  CONSTRAINT [fk_estado_medidor] FOREIGN KEY([estado_medidor])
REFERENCES [dbo].[c_estado_medidor] ([cod_estado])
GO
ALTER TABLE [dbo].[c_medidor] CHECK CONSTRAINT [fk_estado_medidor]
GO
ALTER TABLE [dbo].[c_medidor_lectura]  WITH CHECK ADD  CONSTRAINT [fk_cml_cod_estado] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[c_estado_lectura] ([cod_estado])
GO
ALTER TABLE [dbo].[c_medidor_lectura] CHECK CONSTRAINT [fk_cml_cod_estado]
GO
ALTER TABLE [dbo].[c_medidor_lectura]  WITH CHECK ADD  CONSTRAINT [fk_cml_cod_medidor] FOREIGN KEY([cod_medidor])
REFERENCES [dbo].[c_medidor] ([cod_medidor])
GO
ALTER TABLE [dbo].[c_medidor_lectura] CHECK CONSTRAINT [fk_cml_cod_medidor]
GO
ALTER TABLE [dbo].[c_modifica_lectura]  WITH CHECK ADD  CONSTRAINT [fk_cod_lectura] FOREIGN KEY([cod_lectura])
REFERENCES [dbo].[c_medidor_lectura] ([cod_lectura])
GO
ALTER TABLE [dbo].[c_modifica_lectura] CHECK CONSTRAINT [fk_cod_lectura]
GO
ALTER TABLE [dbo].[c_situacion_conexion]  WITH CHECK ADD  CONSTRAINT [fk_sc_cod_conexion] FOREIGN KEY([cod_conexion])
REFERENCES [dbo].[c_conexion] ([cod_conexion])
GO
ALTER TABLE [dbo].[c_situacion_conexion] CHECK CONSTRAINT [fk_sc_cod_conexion]
GO
ALTER TABLE [dbo].[c_situacion_conexion]  WITH CHECK ADD  CONSTRAINT [fk_sc_cod_estado] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[c_estado_conexion] ([cod_estado])
GO
ALTER TABLE [dbo].[c_situacion_conexion] CHECK CONSTRAINT [fk_sc_cod_estado]
GO
ALTER TABLE [dbo].[c_socio]  WITH CHECK ADD  CONSTRAINT [fk_cod_tipo_documento] FOREIGN KEY([cod_tipo_documento])
REFERENCES [dbo].[s_tipo_documento] ([cod_tipo_documento])
GO
ALTER TABLE [dbo].[c_socio] CHECK CONSTRAINT [fk_cod_tipo_documento]
GO
ALTER TABLE [dbo].[c_socio]  WITH CHECK ADD  CONSTRAINT [fk_estado_civil] FOREIGN KEY([cod_ec])
REFERENCES [dbo].[c_estado_civil] ([cod_ec])
GO
ALTER TABLE [dbo].[c_socio] CHECK CONSTRAINT [fk_estado_civil]
GO
ALTER TABLE [dbo].[f_cobranza]  WITH CHECK ADD  CONSTRAINT [fk_co_cod_estado] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[f_estado_cobranza] ([cod_estado])
GO
ALTER TABLE [dbo].[f_cobranza] CHECK CONSTRAINT [fk_co_cod_estado]
GO
ALTER TABLE [dbo].[f_cobranza]  WITH CHECK ADD  CONSTRAINT [fk_co_nro_factura] FOREIGN KEY([id_fact])
REFERENCES [dbo].[f_factura] ([id_fact])
GO
ALTER TABLE [dbo].[f_cobranza] CHECK CONSTRAINT [fk_co_nro_factura]
GO
ALTER TABLE [dbo].[f_consumo_x_socio]  WITH CHECK ADD  CONSTRAINT [fk_cxs_nro_factura] FOREIGN KEY([id_fact])
REFERENCES [dbo].[f_factura] ([id_fact])
GO
ALTER TABLE [dbo].[f_consumo_x_socio] CHECK CONSTRAINT [fk_cxs_nro_factura]
GO
ALTER TABLE [dbo].[f_cuenta_especial_cabecera]  WITH CHECK ADD  CONSTRAINT [fk_cec_cod_conexion] FOREIGN KEY([cod_conexion])
REFERENCES [dbo].[c_conexion] ([cod_conexion])
GO
ALTER TABLE [dbo].[f_cuenta_especial_cabecera] CHECK CONSTRAINT [fk_cec_cod_conexion]
GO
ALTER TABLE [dbo].[f_cuenta_especial_cabecera]  WITH CHECK ADD  CONSTRAINT [fk_cec_cod_tarifa_especial] FOREIGN KEY([cod_tarifa_especial])
REFERENCES [dbo].[f_tarifa_especial] ([cod_tarifa_especial])
GO
ALTER TABLE [dbo].[f_cuenta_especial_cabecera] CHECK CONSTRAINT [fk_cec_cod_tarifa_especial]
GO
ALTER TABLE [dbo].[f_cuenta_especial_cuota]  WITH CHECK ADD  CONSTRAINT [fk_cecuo_cod_estado] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[f_estado_cuenta_especial] ([cod_estado])
GO
ALTER TABLE [dbo].[f_cuenta_especial_cuota] CHECK CONSTRAINT [fk_cecuo_cod_estado]
GO
ALTER TABLE [dbo].[f_cuenta_especial_cuota]  WITH CHECK ADD  CONSTRAINT [fk_cecuo_cod_tarifa_especial] FOREIGN KEY([cod_tarifa_especial])
REFERENCES [dbo].[f_tarifa_especial] ([cod_tarifa_especial])
GO
ALTER TABLE [dbo].[f_cuenta_especial_cuota] CHECK CONSTRAINT [fk_cecuo_cod_tarifa_especial]
GO
ALTER TABLE [dbo].[f_factura]  WITH CHECK ADD  CONSTRAINT [fk_f_cod_conexion] FOREIGN KEY([cod_conexion])
REFERENCES [dbo].[c_conexion] ([cod_conexion])
GO
ALTER TABLE [dbo].[f_factura] CHECK CONSTRAINT [fk_f_cod_conexion]
GO
ALTER TABLE [dbo].[f_factura]  WITH CHECK ADD  CONSTRAINT [fk_f_cod_estado] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[f_estado_factura] ([cod_estado])
GO
ALTER TABLE [dbo].[f_factura] CHECK CONSTRAINT [fk_f_cod_estado]
GO
ALTER TABLE [dbo].[f_factura]  WITH CHECK ADD  CONSTRAINT [fk_f_cod_tipo_factura] FOREIGN KEY([cod_tipo_factura])
REFERENCES [dbo].[f_tipo_factura] ([cod_tipo_factura])
GO
ALTER TABLE [dbo].[f_factura] CHECK CONSTRAINT [fk_f_cod_tipo_factura]
GO
ALTER TABLE [dbo].[f_factura_detalle]  WITH CHECK ADD  CONSTRAINT [fk_fd_nro_factura] FOREIGN KEY([id_fact])
REFERENCES [dbo].[f_factura] ([id_fact])
GO
ALTER TABLE [dbo].[f_factura_detalle] CHECK CONSTRAINT [fk_fd_nro_factura]
GO
ALTER TABLE [dbo].[f_nota_credito]  WITH CHECK ADD  CONSTRAINT [fk_nc_cod_conexion] FOREIGN KEY([cod_conexion])
REFERENCES [dbo].[c_conexion] ([cod_conexion])
GO
ALTER TABLE [dbo].[f_nota_credito] CHECK CONSTRAINT [fk_nc_cod_conexion]
GO
ALTER TABLE [dbo].[f_nota_credito]  WITH CHECK ADD  CONSTRAINT [fk_nc_cod_estado] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[f_estado_nota_credito] ([cod_estado])
GO
ALTER TABLE [dbo].[f_nota_credito] CHECK CONSTRAINT [fk_nc_cod_estado]
GO
ALTER TABLE [dbo].[f_nota_credito]  WITH CHECK ADD  CONSTRAINT [fk_nc_nro_factura] FOREIGN KEY([id_fact])
REFERENCES [dbo].[f_factura] ([id_fact])
GO
ALTER TABLE [dbo].[f_nota_credito] CHECK CONSTRAINT [fk_nc_nro_factura]
GO
ALTER TABLE [dbo].[o_orden_servicio]  WITH CHECK ADD  CONSTRAINT [fk_cod_tipo_orden] FOREIGN KEY([cod_tipo_orden])
REFERENCES [dbo].[o_tipo_orden_servicio] ([cod_tipo_orden])
GO
ALTER TABLE [dbo].[o_orden_servicio] CHECK CONSTRAINT [fk_cod_tipo_orden]
GO
ALTER TABLE [dbo].[o_orden_servicio]  WITH CHECK ADD  CONSTRAINT [fk_os_cod_conexion] FOREIGN KEY([cod_conexion])
REFERENCES [dbo].[c_conexion] ([cod_conexion])
GO
ALTER TABLE [dbo].[o_orden_servicio] CHECK CONSTRAINT [fk_os_cod_conexion]
GO
ALTER TABLE [dbo].[o_orden_servicio_detalle]  WITH CHECK ADD  CONSTRAINT [fk_oss_cod_orden] FOREIGN KEY([cod_orden_servicio])
REFERENCES [dbo].[o_orden_servicio] ([cod_orden_servicio])
GO
ALTER TABLE [dbo].[o_orden_servicio_detalle] CHECK CONSTRAINT [fk_oss_cod_orden]
GO
ALTER TABLE [dbo].[s_acta]  WITH CHECK ADD  CONSTRAINT [fk_cod_mandato] FOREIGN KEY([cod_mandato])
REFERENCES [dbo].[s_mandato] ([cod_mandato])
GO
ALTER TABLE [dbo].[s_acta] CHECK CONSTRAINT [fk_cod_mandato]
GO
ALTER TABLE [dbo].[s_solicitud_cambio_nombre]  WITH CHECK ADD  CONSTRAINT [fk_cod_estado_cnombre] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[s_tipo_estado] ([cod_estado])
GO
ALTER TABLE [dbo].[s_solicitud_cambio_nombre] CHECK CONSTRAINT [fk_cod_estado_cnombre]
GO
ALTER TABLE [dbo].[s_solicitud_conexion]  WITH CHECK ADD  CONSTRAINT [fk_cod_estado] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[s_tipo_estado] ([cod_estado])
GO
ALTER TABLE [dbo].[s_solicitud_conexion] CHECK CONSTRAINT [fk_cod_estado]
GO
ALTER TABLE [dbo].[s_solicitud_conexion]  WITH CHECK ADD  CONSTRAINT [fk_cod_tipo_regimen] FOREIGN KEY([cod_tipo_regimen])
REFERENCES [dbo].[s_tipo_regimen] ([cod_tipo_regimen])
GO
ALTER TABLE [dbo].[s_solicitud_conexion] CHECK CONSTRAINT [fk_cod_tipo_regimen]
GO
ALTER TABLE [dbo].[s_solicitud_desconexion]  WITH CHECK ADD  CONSTRAINT [fk_cod_estado_desc] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[s_tipo_estado] ([cod_estado])
GO
ALTER TABLE [dbo].[s_solicitud_desconexion] CHECK CONSTRAINT [fk_cod_estado_desc]
GO
