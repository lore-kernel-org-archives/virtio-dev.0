Return-Path: virtio-dev-return-6905-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05837985A3E
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Mar 2020 16:43:36 +0000 (UTC)
References: <874kv15o4q.fsf@linaro.org>
 <20200309154637.GJ7668@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200309154637.GJ7668@stefanha-x1.localdomain>
Date: Mon, 09 Mar 2020 16:43:31 +0000
Message-ID: <871rq1jx70.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Fri, Mar 06, 2020 at 06:33:57PM +0000, Alex Benn=C3=A9e wrote:
>> So the context of my question is what sort of common software layer is
>> required to implement a virtio backend entirely in userspace?
>
> Yes and no.
>
> vhost-user is currently the most widely-used (cross-VMM) interface for
> out-of-process VIRTIO device emulation.
>
> However, it's not a library, just a protocol specification involving
> UNIX domain sockets.  You mentioned the various implementations below:
>
<snip>
>
>> backend be emulated purely with some shared memory and some sockets for
>> passing messages/kicks from/to the VMM which then deals with the hypervi=
sor
>> specifics of the virtio-transport?
>
> Yes, that is what vhost-user does.

I thought so - but does any vhost-user implementation assume it has
access to the entire of the guests memory space? I can see why that
might be seen as undesirable from a security point of view.

So aside from virtiofsd and crosvm's various pieces for crostini
emulation what other out-of-VMM device emulation daemons are you aware
of?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

