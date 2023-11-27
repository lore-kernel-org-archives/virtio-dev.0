Return-Path: <virtio-dev-return-14067-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E44C4167B
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Nov 2023 11:20:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 32C422A8F2
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Nov 2023 11:20:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12C8D9863B7
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Nov 2023 11:20:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E60F598638E; Mon, 27 Nov 2023 11:20:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8FD0986394
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Nov 2023 11:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 5kPlZDTvMC2XNIo4ZCQhZQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701084053; x=1701688853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS24AK32tM3GfInvlW04qWCKT7XB5Eb3IEiuHhd3v50=;
        b=VU68gocLfauyUSl+ywBtn9EStYomwBg24kEtapPkLUMhIOI+WhMD1F6m+DHz6LXSnZ
         gKH0qcIL8XFgFF7VvxKQ8AMAgXLtSW5Ea0r8QwIe30YUj0HpruyGu37nxuqg2JD4ATzE
         J5PRLS8sVlNYOFHU9pOwp25dLUagyxxDe6jRhVQDqC1gdRktKvn3ZnldkE76rnqYYo4t
         wMcLy17I20PSpkQbtijwCKaqdgWlaXSQ5YaVjPXPTDY5RV+y9wjF8Zx9oQ/a3Nt7BehG
         wEjsrC/AjAozjRIZHvHQTzA510RTIUtCMAislRN/U3Cxk4k+QzyGpji0/ZhlXS7XAOF7
         CMQg==
X-Gm-Message-State: AOJu0YyR/+UK2ij3574fbITi/uXmV3BymM5EAc+fao9dZh3ZYILozbKo
	m2i2OjAu57ND5rVHc8o2TdvJIT9MhSuYNtmKqOtKEJ4OjBmcXwWPgjEeZ4GFN5Ikg0pY2Nfsqxq
	HBScWlcGh6Ea/gF9gW/GNlfhyOsha+aA2qlOz
X-Received: by 2002:a5d:484c:0:b0:32f:8a08:3617 with SMTP id n12-20020a5d484c000000b0032f8a083617mr8499655wrs.5.1701084053449;
        Mon, 27 Nov 2023 03:20:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuyPajtSLTlprgw0n8AfYPUQuzWCTY53MhbgZv6g1OthuT9mYu3iQuOxwobEnq1CegIlf4xQ==
X-Received: by 2002:a5d:484c:0:b0:32f:8a08:3617 with SMTP id n12-20020a5d484c000000b0032f8a083617mr8499637wrs.5.1701084053087;
        Mon, 27 Nov 2023 03:20:53 -0800 (PST)
Date: Mon, 27 Nov 2023 12:20:51 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Radu Ocica <rocica@blackberry.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"anton.yakovlev@opensynergy.com" <anton.yakovlev@opensynergy.com>
Message-ID: <ZWR7k4cya3p2auFg@fedora>
References: <02725a6508584ed2aa8b31c9e9f4264a@blackberry.com>
 <ZTeZ6YjyR0BJOylw@fedora>
 <6df30c7945ca4ac2bb1c170b1c028719@blackberry.com>
 <CAHYGQ0yXPY2NU25N3jh=MH7=PUjkWy5R-SmtaMOVP-VCPPuq3w@mail.gmail.com>
 <37eaf0dc2bdb4a7b936618b48dd00ac2@blackberry.com>
 <ZVIFlIcOjW5+jgaH@fedora>
 <dd0ecb29d8de4fc5a775469ea51af461@blackberry.com>
MIME-Version: 1.0
In-Reply-To: <dd0ecb29d8de4fc5a775469ea51af461@blackberry.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] virtio-snd comments/questions

On Wed, Nov 22, 2023 at 06:59:15PM +0000, Radu Ocica wrote:
> Hi Matias,
> 
> 
> > >
> > > > Could you elaborate on this? Which audio backend would not support
> > > > PAUSE? I am not very familiar with audio engines.
> > >
> > > For instance in linux, alsa-lib has a flag that specifies pause support by a PCM stream:
> > > #define SNDRV_PCM_INFO_PAUSE                       (1UL<<19)  /* pause ioctl is supported */
> > > The snd_pcm_pause API can only be used successfully if the PCM stream has this bit set in its PCM info.
> > > A similar concept exists in QNX sound.
> > >
> 
> > Oh, I see. I was unaware of this flag. Not supporting PAUSE in the host
> > sound card may not be a problem. In our case, the pw backend in the host
> > stops playing when a guest sends STOP immediately. As soon as START is
> > sent again, pw begins consuming from the tx queue. Tx buffers are only
> > signaled as complete after START is reissued. In the meantime, the msgs
> > are in the available ring of the tx queue.
> 
> > > However, if the host stream does not support pause the only option
> > > left is to perform a drop operation on the host stream and in this
> > > case all pending messages in the tx/rx queue need to be returned to
> > > the guest as completed, because at the next start possibly all
> > > messages will be needed to prime the host stream (in the case of
> > > playback).
> 
> > If STOP is sent and there is still msgs in the TX queue, can't the
> > device just stop playing until START is issued again? Why does the
> > device require to drop the msgs in this case?
> Invoking the pcm drop API on the host has been the modality chosen by us to stop playing, with immediate effect. Whatever io messages were buffered at the time by the host pcm device need then to be returned to the guest driver as completed. Messages in the TX queue at the time of the STOP request can be left untouched. Depending on the relationship between number of periods used by the guest device vs number of periods used by the host device, the TX queue might be normally empty though (for instance if host and guest device use the same number of periods, all pcm data received from the guest driver would end up immediately in the backend buffer).
> The way you describe STOP it sounds like you just stop writing new data to the host pcm device, without invoking any API to explicitly stop it (if pause API not available for the host pcm device). This allows for currently backend buffered data to continue playing and correspondingly io messages need to be returned to the guest driver as they are consumed. If no START is received before the backend buffered data completes playing, the host device then underruns. At this point it either continues running by injecting silence or stops, depending on setup options. The effective stop of sound playback occurs when the backend buffered data completes playing, which might be after a considerable delay, depending on backend buffer size. Keeping the host device running and injecting silence sounds like the easiest way to avoid the need to re-prepare the host pcm device when restarting. Have I captured your approach accurately?

For example, in the audio backend for pipewire, the STOP cmd stops
playing, i.e., the device stops to consume from the tx queue. This cmd
translates to something like `stream.set_active(false)`. In the pw
backend, the consumption happens from a thread named the threadloop.
When setting `set_active(false)`, such a thread stops to execute. There
is no need to insert silence from the audio backend. The threadloop
starts to execute again and thus consuming from tx when issuing
`set_active(true)` during the START cmd.

Matias


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

