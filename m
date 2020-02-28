Return-Path: virtio-dev-return-6811-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3CA0985ECF
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Feb 2020 10:30:47 +0000 (UTC)
References: <87mu93vwy2.fsf@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <db75fc2b-ac2e-2351-cc3c-cdb42a50ac24@siemens.com>
Date: Fri, 28 Feb 2020 11:30:37 +0100
MIME-Version: 1.0
In-Reply-To: <87mu93vwy2.fsf@linaro.org>
Content-Language: en-US
Subject: [virtio-dev] Re: VIRTIO adoption in other hypervisors
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>
List-ID: <virtio-dev.lists.oasis-open.org>

On 28.02.20 11:16, Alex Benn=C3=A9e wrote:
> Hi,
>=20
> I'm currently trying to get my head around virtio and was wondering how
> widespread adoption of virtio is amongst the various hypervisors and
> emulators out there.
>=20
> Obviously I'm familiar with QEMU both via KVM and even when just doing
> plain emulation (although with some restrictions). As far as I'm aware
> the various Rust based VMMs have vary degrees of support for virtio
> devices over KVM as well. CrosVM specifically is embracing virtio for
> multi-process device emulation.
>=20
> I believe there has been some development work for supporting VIRTIO on
> Xen although it seems to have stalled according to:
>=20
>    https://wiki.xenproject.org/wiki/Virtio_On_Xen
>=20
> Recently at KVM Forum there was Jan's talk about Inter-VM shared memory
> which proposed ivshmemv2 as a VIRTIO transport:
>=20
>    https://events19.linuxfoundation.org/events/kvm-forum-2019/program/sch=
edule/
>=20
> As I understood it this would allow Xen (and other hypervisors) a simple
> way to be able to carry virtio traffic between guest and end point.
>=20
> So some questions:
>=20
>    - Am I missing anything out in that summary?
>    - How about HyperV and the OSX equivalent?
>    - Do any other type-1 hypervisors support virtio?

 From the top of my head, some other hypervisors with virtio support=20
(irrespective of any classification):

https://wiki.freebsd.org/bhyve
https://projectacrn.org/
http://www.xhypervisor.org/
https://www.opensynergy.com/automotive-hypervisor/

But there are likely more.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

