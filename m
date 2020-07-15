Return-Path: virtio-dev-return-7555-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8E6C98605B
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jul 2020 17:09:51 +0000 (UTC)
Date: Wed, 15 Jul 2020 19:09:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200715190939.60b562f9.cohuck@redhat.com>
In-Reply-To: <871rlcybni.fsf@linaro.org>
References: <87r1tdydpz.fsf@linaro.org>
	<20200715114855.GF18817@stefanha-x1.localdomain>
	<877dv4ykin.fsf@linaro.org>
	<20200715154732.GC47883@stefanha-x1.localdomain>
	<871rlcybni.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 15 Jul 2020 17:40:33 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> I was also wondering about the efficiency of doorbells/notifications the
> other way. AFAIUI for both PCI and MMIO only a single write is required
> to the notify flag which causes a trap to the hypervisor and the rest of
> the processing. The hypervisor doesn't have the cost multiple exits to
> read the guest state although it obviously wants to be as efficient as
> possible passing the data back up to what ever is handling the backend
> of the device so it doesn't need to do multiple context switches.
>=20
> Has there been any investigation into other mechanisms for notifying the
> hypervisor of an event - for example using a HYP call or similar
> mechanism?

For ccw devices, we do a 'diagnose' call (which is basically a
hypercall). It has some parameters (including the queue the guest is
notifying for), so the host already has that information when the exit
happens.

> My gut tells me this probably doesn't make any difference as a trap to
> the hypervisor is likely to cost the same either way because you still
> need to save the guest context before actioning something but it would
> be interesting to know if anyone has looked at it. Perhaps there is a
> benefit in partitioned systems where core running the guest can return
> straight away after initiating what it needs to internally in the
> hypervisor to pass the notification to something that can deal with it?

I guess that depends mostly upon whether there is further interaction
needed, or if the guest can give the host all needed info in one go.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

