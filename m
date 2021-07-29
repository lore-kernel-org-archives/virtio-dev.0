Return-Path: <virtio-dev-return-8442-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D092986476
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jul 2021 16:18:51 +0000 (UTC)
Date: Thu, 29 Jul 2021 17:18:43 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <20210729161843.GN6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-12-cristian.marussi@arm.com>
 <20210728145033.wpobgpxane2t2brc@bogus>
MIME-Version: 1.0
In-Reply-To: <20210728145033.wpobgpxane2t2brc@bogus>
Subject: [virtio-dev] Re: [PATCH v6 11/17] firmware: arm_scmi: Make SCMI transports
 configurable
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 28, 2021 at 03:50:33PM +0100, Sudeep Holla wrote:
> On Mon, Jul 12, 2021 at 03:18:27PM +0100, Cristian Marussi wrote:
> > Add configuration options to be able to select which SCMI transports have
> > to be compiled into the SCMI stack.
> > 
> > Mailbox and SMC are by default enabled if their related dependencies are
> > satisfied.
> > 
> > While doing that move all SCMI related config options in their own
> > dedicated submenu.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > Used a BUILD_BUG_ON() to avoid the scenario where SCMI is configured
> > without any transport. Coul dnot do in any other way in Kconfig due to
> > circular dependencies.
> > 
> > This will be neeed later on to add new Virtio based transport and
> > optionally exclude other transports.
> > ---

Hi Sudeep,

> >  drivers/firmware/Kconfig           | 34 +--------------
> >  drivers/firmware/arm_scmi/Kconfig  | 70 ++++++++++++++++++++++++++++++
> >  drivers/firmware/arm_scmi/Makefile |  4 +-
> >  drivers/firmware/arm_scmi/common.h |  4 +-
> >  drivers/firmware/arm_scmi/driver.c |  6 ++-
> >  5 files changed, 80 insertions(+), 38 deletions(-)
> >  create mode 100644 drivers/firmware/arm_scmi/Kconfig
> > 
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index 1db738d5b301..8d41f73f5395 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -6,39 +6,7 @@
> >  
> >  menu "Firmware Drivers"
> >  
> > -config ARM_SCMI_PROTOCOL
> > -	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
> > -	depends on ARM || ARM64 || COMPILE_TEST
> > -	depends on MAILBOX || HAVE_ARM_SMCCC_DISCOVERY
> > -	help
> > -	  ARM System Control and Management Interface (SCMI) protocol is a
> > -	  set of operating system-independent software interfaces that are
> > -	  used in system management. SCMI is extensible and currently provides
> > -	  interfaces for: Discovery and self-description of the interfaces
> > -	  it supports, Power domain management which is the ability to place
> > -	  a given device or domain into the various power-saving states that
> > -	  it supports, Performance management which is the ability to control
> > -	  the performance of a domain that is composed of compute engines
> > -	  such as application processors and other accelerators, Clock
> > -	  management which is the ability to set and inquire rates on platform
> > -	  managed clocks and Sensor management which is the ability to read
> > -	  sensor data, and be notified of sensor value.
> > -
> > -	  This protocol library provides interface for all the client drivers
> > -	  making use of the features offered by the SCMI.
> > -
> > -config ARM_SCMI_POWER_DOMAIN
> > -	tristate "SCMI power domain driver"
> > -	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> > -	default y
> > -	select PM_GENERIC_DOMAINS if PM
> > -	help
> > -	  This enables support for the SCMI power domains which can be
> > -	  enabled or disabled via the SCP firmware
> > -
> > -	  This driver can also be built as a module.  If so, the module
> > -	  will be called scmi_pm_domain. Note this may needed early in boot
> > -	  before rootfs may be available.
> > +source "drivers/firmware/arm_scmi/Kconfig"
> >  
> >  config ARM_SCPI_PROTOCOL
> >  	tristate "ARM System Control and Power Interface (SCPI) Message Protocol"
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> > new file mode 100644
> > index 000000000000..479fc8a3533e
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +menu "ARM System Control and Management Interface Protocol"
> > +
> > +config ARM_SCMI_PROTOCOL
> > +	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
> > +	depends on ARM || ARM64 || COMPILE_TEST
> > +	help
> > +	  ARM System Control and Management Interface (SCMI) protocol is a
> > +	  set of operating system-independent software interfaces that are
> > +	  used in system management. SCMI is extensible and currently provides
> > +	  interfaces for: Discovery and self-description of the interfaces
> > +	  it supports, Power domain management which is the ability to place
> > +	  a given device or domain into the various power-saving states that
> > +	  it supports, Performance management which is the ability to control
> > +	  the performance of a domain that is composed of compute engines
> > +	  such as application processors and other accelerators, Clock
> > +	  management which is the ability to set and inquire rates on platform
> > +	  managed clocks and Sensor management which is the ability to read
> > +	  sensor data, and be notified of sensor value.
> > +
> > +	  This protocol library provides interface for all the client drivers
> > +	  making use of the features offered by the SCMI.
> > +
> 
> May be you can add if condition here to remove the depends on ARM_SCMI_PROTOCOL
> 
> if ARM_SCMI_PROTOCOL
> 

I'll do.

> > +config ARM_SCMI_HAVE_TRANSPORT
> > +	bool
> > +	help
> > +	  This declares whether at least one SCMI transport has been configured.
> > +	  Used to trigger a build bug when trying to build SCMI without any
> > +	  configured transport.
> > +
> > +config ARM_SCMI_TRANSPORT_MAILBOX
> > +	bool "SCMI transport based on Mailbox"
> > +	depends on ARM_SCMI_PROTOCOL && MAILBOX
> 
> And drop ARM_SCMI_PROTOCOL above
> 

Ditto

> > +	select ARM_SCMI_HAVE_TRANSPORT
> > +	default y
> 
> Do we need a user visible choice if it is always default on ?
> 

I'll leave for now as said offline to be able to not build unsupported
transport.

> > +	help
> > +	  Enable mailbox based transport for SCMI.
> > +
> > +	  If you want the ARM SCMI PROTOCOL stack to include support for a
> > +	  transport based on mailboxes, answer Y.
> > +	  A matching DT entry will also be needed to indicate the effective
> > +	  presence of this kind of transport.
> > +
> 
> I would drop the above comment on matching DT.
> 

Yes right, I was in doubt in fact if it was sensible place for that
comment.

> > +config ARM_SCMI_TRANSPORT_SMC
> > +	bool "SCMI transport based on SMC"
> > +	depends on ARM_SCMI_PROTOCOL && HAVE_ARM_SMCCC_DISCOVERY
> 
> Ditto
> 

DittoAck :D

> > +	select ARM_SCMI_HAVE_TRANSPORT
> > +	default y
> > +	help
> > +	  Enable SMC based transport for SCMI.
> > +
> > +	  If you want the ARM SCMI PROTOCOL stack to include support for a
> > +	  transport based on SMC, answer Y.
> > +	  A matching DT entry will also be needed to indicate the effective
> > +	  presence of this kind of transport.
> > +
> 
> endif #ARM_SCMI_PROTOCOL
> 

Thanks,
Cristian

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

