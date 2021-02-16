Return-Path: virtio-comment-return-1722-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Date: Tue, 16 Feb 2021 17:31:57 +0000
Message-ID: <DBBPR08MB4790C18DDCA35B7C33D43CF782879@DBBPR08MB4790.eurprd08.prod.outlook.com>
References: <20210212095920.249768-1-peter.hilber@opensynergy.com>
 <20210216161208.GA1463@shell.armlinux.org.uk>
 <DBBPR08MB4790802EA436661E4AEEEFF682879@DBBPR08MB4790.eurprd08.prod.outlook.com>
 <20210216165705.GB1463@shell.armlinux.org.uk>
In-Reply-To: <20210216165705.GB1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v6] Add virtio SCMI device specification
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Peter Hilber <peter.hilber@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, Cristian Marussi <Cristian.Marussi@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Sent: Tuesday, February 16, 2021 4:57 PM
>=20
> On Tue, Feb 16, 2021 at 04:48:30PM +0000, Souvik Chakravarty wrote:
> > > From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> > > Sent: Tuesday, February 16, 2021 4:12 PM I'm not too familiar with
> > > SCMI, but I think this question is worth asking...
> > >
> > > If the SCMI protocol can be used to control system level power
> > > management, and if the intention is to expose this firmware
> > > interface to virtualised guests, what prevents a guest from
> > > controlling the power settings for stuff it should not have access to=
?
> > >
> > > For example, if it's possible to tell the system to power down a
> > > critical host component through SCMI, what would prevent a guest
> > > requesting that critical component from having its power cut?
> >
> > Short summary:
> > SCMI as a protocol has built in requirements where only the resources
> > (specific clock, sensor etc.) which are specifically needed by a VM
> > are exposed to it. Resources are mapped by Identifiers and if the VM
> > tries to access an identifier which it does not have access to, the
> > SCMI backend can simply ignore or return DENIED. At no point is direct
> access to any power mgmt. hardware granted to any VM, nor is a VM
> supposed to have global access to all system resources.
> > There is always a firmware backend which controls the hardware and
> > services SCMI command requests from agents/guests, after due validation=
.
> > The SCMI device/firmware which implements the SCMI backend, is
> > responsible for implementing these resource isolation guarantees.
>=20
> You seem to be saying the SCMI firmware itself is responsible for
> implementing this. Given what I've seen from vendors in ATF, this does no=
t
> leave me with much confidence that there will be sufficient security. It
> concerns me more when you say that the "backend" is responsible for
> making these decisions. This doesn't sound good to me.

[Somehow realizing I cannot post to virtio-dev...]
Let me try to add a bit of color because I realize I did mix up a few usage=
 models=20
(baremetal & virtualized) in my previous reply.=20

Let me rephrase from the perspective of a virtualized system using Virtio S=
CMI specifically.=20
In this specific case, the commands issued by the VM will go to the SCMI vi=
rtio backend
which is in the host. This can then choose can choose to reject VM issued S=
CMI commands.

>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

