Return-Path: <virtio-dev-return-14128-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFDDC4167B
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 10:17:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8E1EF2AC62
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 10:17:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70E5C9868F3
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 10:17:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 56F129866C1; Wed,  6 Dec 2023 10:17:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 481659867BC
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Dec 2023 10:17:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: spDXhwb5ObuOZZss4mUHXg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857851; x=1702462651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZthwVw7KjsI8I+9PlqnZOgHm5xy7kHr5KidQMVYQcGE=;
        b=intVcqXmILD6ifRyGzsefxo8KsiXknHcLerpC02sUWVSIQSIiqoVXcUVGW85agfDiL
         YFFoh02j46JUqibBGSY+3x1vMwf++U/vbL/XO7bwdoIkX5zbuOFzKtkifLqjUCDJijSw
         /5KRTPuXACjWKNM1EmN9pOLTaOCFgqfpUh623DUxovZti4detADdUyh7tqGs8Bw5iy58
         Kh5yNpUA40t1r+lfVKlZRG+qUZN2kLKmIAQOMQl17Xa2xsGK6ICHHoG4FgM9Wdf9oj+S
         nZYQ8AGNq2yCFv2RgivETM0HRUef2kCVppiQ+Ri2U1y7dHkVg5TcJpiFR5DsAkAG86e8
         aWNA==
X-Gm-Message-State: AOJu0YyAetnVzjSYw9ytWfOMV7iLXcfKbC2u6F5oTnEiinbHcvO1iUNH
	QPI3R4CVwZXMwp40B0dqI1BotK7lN8N874tLfRMw4YKnS+AKjIkuWPg81OoWdt6C+oL0q7OXzif
	BZx/0mKKN+jI140C3AzAjEO1soJCY
X-Received: by 2002:a2e:86da:0:b0:2c9:f37a:c018 with SMTP id n26-20020a2e86da000000b002c9f37ac018mr347174ljj.25.1701857851053;
        Wed, 06 Dec 2023 02:17:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPl8+fLS9RfwmDYMetZQ9bkpoS0MlfW2jFfAgydrG6qT7Zx2NnrC+7cBxEh2HmfXbGBidJAg==
X-Received: by 2002:a2e:86da:0:b0:2c9:f37a:c018 with SMTP id n26-20020a2e86da000000b002c9f37ac018mr347167ljj.25.1701857850675;
        Wed, 06 Dec 2023 02:17:30 -0800 (PST)
Date: Wed, 6 Dec 2023 05:17:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: David Stevens <stevensd@chromium.org>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20231206051652-mutt-send-email-mst@kernel.org>
References: <20231204094123.856214-1-stevensd@chromium.org>
 <20231204094123.856214-2-stevensd@chromium.org>
 <CACGkMEuHLs=+8_RHVa9eTXfHLqo_Ra6hSrnT9k8DAG_0yz0pvQ@mail.gmail.com>
 <CAD=HUj6bBOOCWmrbxBHKymfAr3UVUL7S57FtffHi0vEzVmewDA@mail.gmail.com>
 <CACGkMEuGY9y5Zt9UdL+4V3tntnR4EyHHCRqX_P4QtmAOL0-Pew@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuGY9y5Zt9UdL+4V3tntnR4EyHHCRqX_P4QtmAOL0-Pew@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v3 1/1] Define a low power mode for
 devices

On Wed, Dec 06, 2023 at 05:16:04PM +0800, Jason Wang wrote:
> On Tue, Dec 5, 2023 at 6:58 PM David Stevens <stevensd@chromium.org> wrote:
> >
> > On Tue, Dec 5, 2023 at 1:18 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Mon, Dec 4, 2023 at 5:41 PM David Stevens <stevensd@chromium.org> wrote:
> > > >
> > > > Define a low power mode for virtio devices where the devices are
> > > > expected to maintain their state. This gives drivers an option for power
> > > > management besides simply resetting their device. In the virtualization
> > > > use case, this allows the guest to be suspended even with stateful
> > > > virtio devices like gpu and fs.
> > > >
> > > > Low power mode is primarily defined at the transport layer. The only
> > > > part that depends on device-type specific details is whether a given
> > > > virtqueue is device driven or driver driven.
> > > >
> > > > This change only defines the transport-specific implementation for
> > > > Virtio over PCI.
> > >
> > > A dumb question, if this is only for PCI, can the device just
> > > implement no_soft_reset via PMC?
> >
> > This is basically No_Soft_Reset, yes. If a change similar to [1] would
> > be acceptable based only on the No_Soft_Reset bit even with no concept
> > of power management in the virtio spec, then I personally don't have
> > any problems with that.
> >
> > [1] https://lore.kernel.org/lkml/20231113055138.117392-1-stevensd@chromium.org/
> 
> So if I read the code correctly, the current Qemu advertises PM but
> without no_soft_reset.
> 
> So this patch seems to break e.g virtio-net and doesn't fix virtio-GPU.
> 
> Thanks
> 
> >
> > -David
> >

what is the breakage exactly? Maybe we need a new feature bit?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

