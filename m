Return-Path: virtio-dev-return-7982-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75DA198630C
	for <virtio-dev@lists.oasis-open.org>; Mon,  8 Feb 2021 10:23:04 +0000 (UTC)
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <s5hpn1h81ot.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <da7fd8cf-9c4d-082d-70bd-b27e242a4eb7@opensynergy.com>
Date: Mon, 8 Feb 2021 11:23:00 +0100
MIME-Version: 1.0
In-Reply-To: <s5hpn1h81ot.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v2 0/9] ALSA: add virtio sound driver
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Takashi,

Thank you for your hints, I actually applied them all. The only question 
that I have is...

On 03.02.2021 19:07, Takashi Iwai wrote:

[snip]

> 
> - Don't PCM stream names need to be unique?  They are all the same
>    string.

What did you mean here? Substream names?


> 
> thanks,
> 
> Takashi
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

