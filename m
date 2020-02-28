Return-Path: virtio-dev-return-6818-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD307985ED0
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Feb 2020 11:18:41 +0000 (UTC)
References: <87mu93vwy2.fsf@linaro.org>
 <fca8366e-662f-af2f-382c-0216d9df63f8@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <fca8366e-662f-af2f-382c-0216d9df63f8@redhat.com>
Date: Fri, 28 Feb 2020 11:18:38 +0000
Message-ID: <87k147vu29.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] VIRTIO adoption in other hypervisors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, jan.kiszka@siemens.com, Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 28/02/20 11:16, Alex Benn=C3=A9e wrote:
>>   - How about HyperV and the OSX equivalent?
>
> OS X Hypervisor.framework just uses QEMU, so it can use virtio devices
> too.  VirtualBox also supports virtio devices.

I guess these don't do any sort of vhost support so all virtio devices
are handled directly in QEMU?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

