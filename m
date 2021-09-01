Return-Path: <virtio-dev-return-8622-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1EB0C986483
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Sep 2021 08:59:31 +0000 (UTC)
References: <87v94ldrqq.fsf@linaro.org>
 <alpine.DEB.2.21.2108041055390.9768@sstabellini-ThinkPad-T480s>
 <0100017b33e585a5-06d4248e-b1a7-485e-800c-7ead89e5f916-000000@email.amazonses.com>
 <CAHFG_=WKjJ1riKtaWC8jm13shc3RtVsNNqd3j9WD9Fq0NeRS2Q@mail.gmail.com>
 <20210813051038.GA77540@laputa>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 01 Sep 2021 09:57:45 +0100
In-reply-to: <20210813051038.GA77540@laputa>
Message-ID: <87eea8hdsh.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [Stratos-dev] Enabling hypervisor agnosticism for VirtIO backends
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Fran??ois Ozog <francois.ozog@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, paul@xen.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, jgross@suse.com, julien@xen.org, Carl van Schaik <cvanscha@qti.qualcomm.com>, Bertrand.Marquis@arm.com, stefanha@redhat.com, Artem_Mygaiev@epam.com, xen-devel@lists.xen.org, olekstysh@gmail.com, Oleksandr_Tyshchenko@epam.com, xen-devel@lists.xenproject.org
List-ID: <virtio-dev.lists.oasis-open.org>


AKASHI Takahiro <takahiro.akashi@linaro.org> writes:

> Hi Fran=C3=A7ois,
>
> On Thu, Aug 12, 2021 at 09:55:52AM +0200, Fran??ois Ozog wrote:
>> I top post as I find it difficult to identify where to make the comments=
.
>
> Thank you for the posting.=20
> I think that we should first discuss more about the goal/requirements/
> practical use cases for the framework.
>
>> 1) BE acceleration
>> Network and storage backends may actually be executed in SmartNICs. As
>> virtio 1.1 is hardware friendly, there may be SmartNICs with virtio 1.1 =
PCI
>> VFs. Is it a valid use case for the generic BE framework to be used in t=
his
>> context?
>> DPDK is used in some BE to significantly accelerate switching. DPDK is a=
lso
>> used sometimes in guests. In that case, there are no event injection but
>> just high performance memory scheme. Is this considered as a use case?
>
> I'm not quite familiar with DPDK but it seems to be heavily reliant
> on not only virtqueues but also kvm/linux features/functionality, say,
> according to [1].
> I'm afraid that DPDK is not suitable for primary (at least, initial)
> target use.
> # In my proposal, virtio-proxy, I have in mind the assumption that we wou=
ld
> # create BE VM as a baremetal application on RTOS (and/or unikernel.)
>
> But as far as virtqueue is concerned, I think we can discuss in general
> technical details as Alex suggested, including:
> - sharing or mapping memory regions for data payload
> - efficient notification mechanism
>
> [1] https://www.redhat.com/en/blog/journey-vhost-users-realm
>
>> 2) Virtio as OS HAL
>> Panasonic CTO has been calling for a virtio based HAL and based on the
>> teachings of Google GKI, an internal HAL seem inevitable in the long ter=
m.
>> Virtio is then a contender to Google promoted Android HAL. Could the
>> framework be used in that context?
>
> In this case, where will the implementation of "HAL" reside?
> I don't think the portability of "HAL" code (as a set of virtio BEs)
> is a requirement here.

When I hear people referring to VirtIO HALs I'm thinking mainly of
VirtIO FE's living in a Linux kernel. There are certainly more devices
that can get added but the commonality on the guest side I think is
pretty much a solved problem (modulo Linux-ism's creeping into the
virtio spec).

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

