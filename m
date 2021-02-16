Return-Path: virtio-comment-return-1721-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Date: Tue, 16 Feb 2021 16:48:30 +0000
Message-ID: <DBBPR08MB4790802EA436661E4AEEEFF682879@DBBPR08MB4790.eurprd08.prod.outlook.com>
References: <20210212095920.249768-1-peter.hilber@opensynergy.com>
 <20210216161208.GA1463@shell.armlinux.org.uk>
In-Reply-To: <20210216161208.GA1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v6] Add virtio SCMI device specification
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>, Peter Hilber <peter.hilber@opensynergy.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Cristian Marussi <Cristian.Marussi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Sent: Tuesday, February 16, 2021 4:12 PM
>=20
> On Fri, Feb 12, 2021 at 10:59:20AM +0100, Peter Hilber wrote:
> > This patch proposes a new virtio device for the Arm SCMI protocol.
> >
> > The device provides a simple transport for the Arm SCMI protocol[1].
> > The *S*ystem *C*ontrol and *M*anagement *I*nterface protocol allows
> > speaking to system controllers that allow orchestrating things like
> > power management, system state management and sensor access. The
> SCMI
> > protocol is used on SoCs where multiple cores and co-processors need
> > access to these resources.
> >
> > The virtio transport allows making use of this protocol in virtualized
> > systems.
> >
> > [1] https://developer.arm.com/docs/den0056/c
> >
> > Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
>=20
> I'm not too familiar with SCMI, but I think this question is worth asking=
...
>=20
> If the SCMI protocol can be used to control system level power management=
,
> and if the intention is to expose this firmware interface to virtualised =
guests,
> what prevents a guest from controlling the power settings for stuff it sh=
ould
> not have access to?
>=20
> For example, if it's possible to tell the system to power down a critical=
 host
> component through SCMI, what would prevent a guest requesting that
> critical component from having its power cut?

Short summary:
SCMI as a protocol has built in requirements where only the resources (spec=
ific clock, sensor etc.)
which are specifically needed by a VM are exposed to it. Resources are mapp=
ed by Identifiers and if
the VM tries to access an identifier which it does not have access to, the =
SCMI backend
can simply ignore or return DENIED. At no point is direct access to any pow=
er mgmt. hardware
granted to any VM, nor is a VM supposed to have global access to all system=
 resources.
There is always a firmware backend which controls the hardware and services
SCMI command requests from agents/guests, after due validation.=20
The SCMI device/firmware which implements the SCMI backend, is responsible =
for implementing these
resource isolation guarantees.

Regards,
Souvik

>=20
> I hope I'm barking up the wrong tree...
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

