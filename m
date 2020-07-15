Return-Path: virtio-dev-return-7551-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5572F985E55
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jul 2020 13:29:08 +0000 (UTC)
References: <87r1tdydpz.fsf@linaro.org>
 <20200715114855.GF18817@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200715114855.GF18817@stefanha-x1.localdomain>
Date: Wed, 15 Jul 2020 14:29:04 +0100
Message-ID: <877dv4ykin.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=C3=A9e wrote:
>> I'm slightly confused by the MSI terminology because this only seems to
>> be relevant for the PCI legacy interface and AFAICT only touch the
>> outgoing path in setup and del_vq. Do incoming MSI interrupts just get
>> mapped directly to the appropriate handler function to process the
>> queues or the config?
>
> When MSI is used the VIRTIO ISR register does not need to be read by the
> guest interrupt handler.
>
>> Finally I'm curious if this is just a problem avoided by the s390
>> channel approach? Does the use of messages over a channel just avoid the
>> sort of bouncing back and forth that other hypervisors have to do when
>> emulating a device?
>
> What does "bouncing back and forth" mean exactly?

Context switching between guest and hypervisor.

>
> Stefan


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

