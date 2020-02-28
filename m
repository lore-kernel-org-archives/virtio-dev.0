Return-Path: virtio-dev-return-6819-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D787985ED0
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Feb 2020 11:21:43 +0000 (UTC)
References: <87mu93vwy2.fsf@linaro.org>
 <fca8366e-662f-af2f-382c-0216d9df63f8@redhat.com> <87k147vu29.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71f1773d-579d-fec9-cd49-e500bbca1bc4@redhat.com>
Date: Fri, 28 Feb 2020 12:21:35 +0100
MIME-Version: 1.0
In-Reply-To: <87k147vu29.fsf@linaro.org>
Content-Language: en-US
Subject: Re: [virtio-dev] VIRTIO adoption in other hypervisors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: virtualization@lists.linux-foundation.org, jan.kiszka@siemens.com, Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 28/02/20 12:18, Alex Benn=C3=A9e wrote:
>> OS X Hypervisor.framework just uses QEMU, so it can use virtio devices
>> too.  VirtualBox also supports virtio devices.
> I guess these don't do any sort of vhost support so all virtio devices
> are handled directly in QEMU?

OS X can use vhost-user.

Paolo


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

