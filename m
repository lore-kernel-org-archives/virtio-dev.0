Return-Path: <virtio-dev-return-12770-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888D4C7EE23
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 14:35:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D3C4C179147
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 14:35:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDF26986197
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 14:35:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ACB0A9859E5; Sun, 21 May 2023 14:35:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB8DA9859E6
	for <virtio-dev@lists.oasis-open.org>; Sun, 21 May 2023 14:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: eaemW_9ONYy3_KDVns-Qzg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684679698; x=1687271698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHqoc4F4yxRb8yZ7OYMj/uACmQ36I/uIlurzFZBRpos=;
        b=DFebShAkeVvi5fEWUZ9nEAJ2DHtRRgpOJn7pF18cQpaYkzVUIyKH1B/Ig+qk87WLQY
         KrMozHz47CiUtkpw73f5pMP/NNF5ohiqxYl8JZJ6uD5AnEzT1AzHXRcEaVzSCc2k+6lh
         45ofoQHflhLQFRwE7OXzAttl+FuPH6VgTcuY3JaE0UM9sHSiducwubOhiTxVlsOxat05
         SdXY0ML2TBazpenDhRULnijYLeMOQcb66hGlViJA6orYHCrGxmMCkq2Pu4AIPi79SwYj
         mHm7O+SdTKAjcsJY35IE7ITPJCcEnRH38V8XcipIERPJ1jwxEKNBv3jmJvBDPz6kEFRE
         L8Bg==
X-Gm-Message-State: AC+VfDw+fwN4c4qCIM5SbwvgmBVKNNDybhz0hgWzj5+XReSCbKPuE3Ct
	1b32wjIOAvDy7vgM64JWAhkc21/j2dlFVBWYa6YS+C4EDIEL4U0qzg9SQj0c9yU4xB8Au8d7jbB
	+5NZuO1p8MVqN4dI/PPbOfvafVu8HCiItVwZ7
X-Received: by 2002:adf:f591:0:b0:307:8ea4:f8f5 with SMTP id f17-20020adff591000000b003078ea4f8f5mr7941301wro.27.1684679698006;
        Sun, 21 May 2023 07:34:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63IY+4tlu+WfT8NNqgQR3DUYj2a0heaxtl4gv+zQwiwiuKe4NfzaYmpqzVZm9nZZDhEdyXuw==
X-Received: by 2002:adf:f591:0:b0:307:8ea4:f8f5 with SMTP id f17-20020adff591000000b003078ea4f8f5mr7941291wro.27.1684679697674;
        Sun, 21 May 2023 07:34:57 -0700 (PDT)
Date: Sun, 21 May 2023 10:34:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230521103341-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230519020737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E912A8CDE621DF4344DEDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521015236-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481905220D7C38DE46F1FE7DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481905220D7C38DE46F1FE7DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Sun, May 21, 2023 at 01:24:55PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, May 21, 2023 1:58 AM
> 
> > Yes but neither can it support new devices because it does not look for the new
> > device id. So it's fine - I was talking about new devices using extended
> > capability.
> > 
> > We shouldn't just laser-focus on existing software and devices, there's probably
> > more to come.
> >
> Sure, new devices can use new capability.
> I will roll this as separate patch and github issue.
> As we discussed, legacy register access over AQ does not need this capability anyway.
> 
> So not related to v2 discussion.
> I am in middle of splitting this as separate patch unrelated to the v2 for legacy access.
> 
> > 
> > > But that is the case with any existing software, not just seabios.
> > >
> > > New capability is in addition to the existing one.
> > > And code already exists to refer to the old one, so I am not seeing any gain to
> > create them now.
> > > Any new capability that one creates in the future can be in the extended area.
> > 
> > Question is about MCFG in general.  Is adding capability to access MCFG to
> > seabios for pci accesses practical? hard?
> >
> What is MCFG?

This is the name of the ACPI table describing memory mapped pci config
accesses.


> > > You mentioned a perf angle that it takes half the time, but I don't
> > > see how as the only change between legacy and ext is: offset.
> > 
> > For a variety of reasons Linux does not use memory mapped accesses for legacy
> > config space, it uses cf8/cfc for that.
> And does it use memory mapped accesses for non-legacy config space?

No other way to access that, right?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

