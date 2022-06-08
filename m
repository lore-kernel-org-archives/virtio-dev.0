Return-Path: <virtio-comment-return-3108-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <877d61wuc0.fsf@linaro.org>
 <80aace95-6c39-c7b9-61ba-70d60bcd08b2@quicinc.com>
 <c642058f36321cb7dfdfaa4664f5323841b65450.camel@sipsolutions.net>
 <a3856ec8-90d6-df19-2b5f-bc42700b09db@quicinc.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 08 Jun 2022 13:28:25 +0100
In-reply-to: <a3856ec8-90d6-df19-2b5f-bc42700b09db@quicinc.com>
Message-ID: <87v8tbtjpv.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [Stratos-dev] Next VirtIO device for Project Stratos?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Trilok Soni <quic_tsoni@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Matt Spencer <Matt.Spencer@arm.com>, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Christian Pinto <c.pinto@virtualopensystems.com>, Namhyung Kim <namhyung@kernel.org>, Petre Eftime <epetre@amazon.com>, Peter Hilber <peter.hilber@opensynergy.com>, Marcel Holtmann <marcel@holtmann.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, quic_pdaly@quicinc.com, pdaly@quicinc.com, svaddagi@qti.qualcomm.com
List-ID: <virtio-dev.lists.oasis-open.org>


Trilok Soni <quic_tsoni@quicinc.com> writes:

> On 6/1/2022 1:06 PM, Johannes Berg wrote:
>> Hi,
>> Not sure if there was anything you wanted me to comment on, but
>> since
>> I'm "the wifi guy" ... :)
>>=20
>>>> mac80211 wlan / 10
>> FWIW, even though I'm the mac80211 maintainer, I'm not aware of a
>> specification or implementation of this ... I don't know what this is at
>> all.
>>=20
>>>> mac80211 hwsim wireless simulation device / 29
>> This I implemented (both a driver in mac80211-hwsim in the kernel,
>> as
>> well as a device in wmediumd), but I wouldn't really necessarily
>> recommend using it for anything but testing.

I assume the use-case for this is something like a virtualised Android
OS. For cloud native testing I guess a simulation device provides enough of
what you need to exercise the guests network stack. However for real
deployments you need something to allow selection of networks and
reporting of network quality.

I'm not super familiar with the wifi stack but is this all usually
handled in one place or do multiple userspace daemons interrogate the
kernel APIs for this information?

If it all comes through one place perhaps it's enough for it to be given
a pipe to the host to make those queries - effectively creating a proxy
to the real host kernel interface?

>>> I am not sure if this related but virtio-ethernet keeps coming to us as
>>> requirement, I am not sure about the what is the support available in
>>> the various projects including Xen. This is a non-Mobile requirement
>>> particularly from the IOT or Auto segments. It will be nice to do adb
>>> over ethernet in the guest VM from the host shell.
>> For ethernet you have normal virtio-net.
>
> Thanks. Virtio-net is available, but I think e2e usecase w/ Type-1
> Hypervisor is what I am looking for. I believe CrosVM also supports
> Virtio-net but I am not sure if it works w/ Xen or not.

In normal Xen you would have a Dom0 with a traditional kernel driver to
service the backend. In a more modular setup you might want to have a
driver domain that combines the backend with the real HW driver running
as a unikernel?

>
> ---Trilok Soni


--=20
Alex Benn=C3=A9e

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

