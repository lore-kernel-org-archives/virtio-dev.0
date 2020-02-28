Return-Path: virtio-dev-return-6815-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DAC7D985ECF
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Feb 2020 10:58:35 +0000 (UTC)
References: <87mu93vwy2.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fca8366e-662f-af2f-382c-0216d9df63f8@redhat.com>
Date: Fri, 28 Feb 2020 11:58:29 +0100
MIME-Version: 1.0
In-Reply-To: <87mu93vwy2.fsf@linaro.org>
Content-Language: en-US
Subject: Re: [virtio-dev] VIRTIO adoption in other hypervisors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Cc: jan.kiszka@siemens.com, Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>
List-ID: <virtio-dev.lists.oasis-open.org>

On 28/02/20 11:16, Alex Benn=C3=A9e wrote:
>   - How about HyperV and the OSX equivalent?

OS X Hypervisor.framework just uses QEMU, so it can use virtio devices
too.  VirtualBox also supports virtio devices.

Paolo


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

