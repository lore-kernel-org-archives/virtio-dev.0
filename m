Return-Path: virtio-dev-return-7553-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37C30986059
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jul 2020 16:40:39 +0000 (UTC)
References: <87r1tdydpz.fsf@linaro.org>
 <20200715114855.GF18817@stefanha-x1.localdomain>
 <877dv4ykin.fsf@linaro.org>
 <20200715154732.GC47883@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200715154732.GC47883@stefanha-x1.localdomain>
Date: Wed, 15 Jul 2020 17:40:33 +0100
Message-ID: <871rlcybni.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, cohuck@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Wed, Jul 15, 2020 at 02:29:04PM +0100, Alex Benn=C3=A9e wrote:
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>> > On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=C3=A9e wrote:
>> >> Finally I'm curious if this is just a problem avoided by the s390
>> >> channel approach? Does the use of messages over a channel just avoid =
the
>> >> sort of bouncing back and forth that other hypervisors have to do whe=
n
>> >> emulating a device?
>> >
>> > What does "bouncing back and forth" mean exactly?
>>=20
>> Context switching between guest and hypervisor.
>
> I have CCed Cornelia Huck, who can explain the lifecycle of an I/O
> request on s390 channel I/O.

Thanks.

I was also wondering about the efficiency of doorbells/notifications the
other way. AFAIUI for both PCI and MMIO only a single write is required
to the notify flag which causes a trap to the hypervisor and the rest of
the processing. The hypervisor doesn't have the cost multiple exits to
read the guest state although it obviously wants to be as efficient as
possible passing the data back up to what ever is handling the backend
of the device so it doesn't need to do multiple context switches.

Has there been any investigation into other mechanisms for notifying the
hypervisor of an event - for example using a HYP call or similar
mechanism?

My gut tells me this probably doesn't make any difference as a trap to
the hypervisor is likely to cost the same either way because you still
need to save the guest context before actioning something but it would
be interesting to know if anyone has looked at it. Perhaps there is a
benefit in partitioned systems where core running the guest can return
straight away after initiating what it needs to internally in the
hypervisor to pass the notification to something that can deal with it?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

