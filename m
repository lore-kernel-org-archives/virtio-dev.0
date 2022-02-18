Return-Path: <virtio-dev-return-9313-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7F0F9864C3
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 Feb 2022 06:31:59 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
 <6311e54b-f526-8838-ad32-b174da3e8643@opensynergy.com>
In-Reply-To: <6311e54b-f526-8838-ad32-b174da3e8643@opensynergy.com>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 17 Feb 2022 22:31:47 -0800
Message-ID: <CAOGAQer=9EWUbwr760uvBPJ34_Dna5ssQPPUt3N0JTRzM=0R0Q@mail.gmail.com>
Subject: Re: [virtio-dev] virtio-snd spec question
Content-Type: text/plain; charset="UTF-8"
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Feb 6, 2022 at 7:23 AM Anton Yakovlev
<anton.yakovlev@opensynergy.com> wrote:
>
> Hello Roman,
>
> On 02.02.2022 00:57, Roman Kiryanov wrote:
> > Hello,
> >
> > I work in Android Studio Emulator and I am currently implementing a
> > virtio-snd device. We found a spec draft here:
> >
> > https://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de964a947670f93cc3#diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5f5f3918dc5
> > <https://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de964a947670f93cc3#diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5f5f3918dc5>
> >
> > It mentions four virtqueues: ctl, event, rx and tx. It is not very clear
> > where a virtio-snd device should put responses to the ctl requests from
> > the linux kernel driver. There is a kernel driver implementation and we
> > have a virtio-snd device implemented in another emulator, it uses the
> > same virtqueue (ctl) to put ctl responses and the current kernel driver
> > seems happy with this.
> >
> > Do you know if this is expected behavior? I am far from an expert here,
> > but I believe the device and the kernel will race here by reading from
> > the same virtqueue: the device could read VirtQueueElement produced by
> > itself before the kernel if the kernel is not fast enough.
>
> Yes, this is the expected behavior of the device and you are doing
> everything right.
>
> The virtio specification describes kind of single-producer single-
> consumer lockless queue way to work with virtqueues. And if both the
> device and the driver (in this case, the Linux kernel) follow the
> specification, then you don't have to worry about a possible race
> condition.

Hello Anton. Thank you for looking into this. I was able to make the
ctl vq working.

Could you please help with the tx vq? The patch (
https://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de964a947670f93cc3
) says "The driver MUST NOT place device-writable buffers into the tx
queue" while it seems to expect for the device to write status
messages there. Also, it is never mentioned which status messages to
write into the tx virtqueue (I guess it is virtio_snd_pcm_status) and
the virtio_snd_pcm_status::latency_bytes explanation is not very
elaborate. I believe it is the amount of bytes buffered in the device
waiting to go to AUD_write.

Also, it is not very clear if the device is expected to process tx
requests right away or to keep them in the vq until they are
completely sent to AUD_write. When I tried to do the former I noticed
the driver keeps sending me tx requests indefinitely, when I tried to
do the latter, the driver often goes to the XRUN state.

Thank you.

Regards,
Roman.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

