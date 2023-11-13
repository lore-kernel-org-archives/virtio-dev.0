Return-Path: <virtio-dev-return-14058-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB706C4332F
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Nov 2023 11:16:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 072082B07F
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Nov 2023 11:16:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D604E98680E
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Nov 2023 11:16:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B67249867EC; Mon, 13 Nov 2023 11:16:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A626298680B
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Nov 2023 11:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: PemsT-LyOeCFGoHioCVLXw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874199; x=1700478999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuDtzn0d2hjt+A4kJ45X0WzTQrdIg0GheKqfMXN9XEw=;
        b=IbkDvu92TKKq4zcGvQsJT5VBa7asrSKUVlgbPmrKFgHivVMwJHVsvmaUPxFVWvHaPL
         9PHrSEfrbAyetjQ403eTzSfz/xTQnIsDSGam5gE/J21TIaHjIYcsfnrjblT1iFc1h/+b
         idkuNaghH3x5fhVNJOkIGvjLV9910Nvw+CwTV1xW95u4XgwBmjDI3mF+6EOTxNQoUx35
         Lk8avjO7Ar6qiNVKkNKLn+lCWQRAQcksKVCz8CUnYI7+Pfk0uoTTLPaEKzW7Zs24gVNd
         zqB+/jdbMsB1GKMUSdTuDifmenCQubhcezyq9QLJZ2d2hOheyVoCIq3aTrmaP/VygiTS
         Uo8g==
X-Gm-Message-State: AOJu0YxiXnNVUUl3+xddaSGCRu85D3TBTCk+sE62bRnYvRy/CLaR5sOQ
	Ph8OCvHFarRGIgxQqF5Z9MmYxt2Am/Uim3A2HUfW7VU8Yx9sziLgj43JD2zd3R8xkX81m3uGcoJ
	6toTIh0RaHzF93cRyLSU7iDhUfN2A
X-Received: by 2002:a05:600c:3d9a:b0:406:8494:f684 with SMTP id bi26-20020a05600c3d9a00b004068494f684mr4475139wmb.23.1699874199338;
        Mon, 13 Nov 2023 03:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWfiJVCYENmKe12qH7fA+cT8nJhD5faerbGD+wsxXEUsEZ0aQRD60rKu61Xop9XhMO7/1T9A==
X-Received: by 2002:a05:600c:3d9a:b0:406:8494:f684 with SMTP id bi26-20020a05600c3d9a00b004068494f684mr4475126wmb.23.1699874198953;
        Mon, 13 Nov 2023 03:16:38 -0800 (PST)
Date: Mon, 13 Nov 2023 12:16:36 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Radu Ocica <rocica@blackberry.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"anton.yakovlev@opensynergy.com" <anton.yakovlev@opensynergy.com>
Message-ID: <ZVIFlIcOjW5+jgaH@fedora>
References: <02725a6508584ed2aa8b31c9e9f4264a@blackberry.com>
 <ZTeZ6YjyR0BJOylw@fedora>
 <6df30c7945ca4ac2bb1c170b1c028719@blackberry.com>
 <CAHYGQ0yXPY2NU25N3jh=MH7=PUjkWy5R-SmtaMOVP-VCPPuq3w@mail.gmail.com>
 <37eaf0dc2bdb4a7b936618b48dd00ac2@blackberry.com>
MIME-Version: 1.0
In-Reply-To: <37eaf0dc2bdb4a7b936618b48dd00ac2@blackberry.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] virtio-snd comments/questions

Hello, 

On Thu, Nov 09, 2023 at 04:46:45PM +0000, Radu Ocica wrote:
> 
> > Could you elaborate on this? Which audio backend would not support
> > PAUSE? I am not very familiar with audio engines.
> 
> For instance in linux, alsa-lib has a flag that specifies pause support by a PCM stream:
> #define SNDRV_PCM_INFO_PAUSE                       (1UL<<19)  /* pause ioctl is supported */
> The snd_pcm_pause API can only be used successfully if the PCM stream has this bit set in its PCM info.
> A similar concept exists in QNX sound.
> 

Oh, I see. I was unaware of this flag. Not supporting PAUSE in the host
sound card may not be a problem. In our case, the pw backend in the host
stops playing when a guest sends STOP immediately. As soon as START is
sent again, pw begins consuming from the tx queue. Tx buffers are only
signaled as complete after START is reissued. In the meantime, the msgs
are in the available ring of the tx queue.

> However, if the host stream does not support pause the only option
> left is to perform a drop operation on the host stream and in this
> case all pending messages in the tx/rx queue need to be returned to
> the guest as completed, because at the next start possibly all
> messages will be needed to prime the host stream (in the case of
> playback).

If STOP is sent and there is still msgs in the TX queue, can't the
device just stop playing until START is issued again? Why does the
device require to drop the msgs in this case?

Thanks, Matias.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

