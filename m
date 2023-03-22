Return-Path: <virtio-dev-return-11703-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC7CC6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 03:53:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7C9D826A36
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 03:53:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7133D986456
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 03:53:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 682B898643D; Wed, 22 Mar 2023 03:53:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56950983DA0
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Mar 2023 03:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jvr4HKTLPbSNpbIf8Kqrkw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679457191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRQEQsn9pksMXilj7dr3jDwK+wTJ6zkeFSo5WiuIq40=;
        b=M5XSuLFliX7xNe2538UY9RrJMsuT+6OQSH8+Rhhf2s0J5Lfd3ZoD01JDMxhA9cx+Lq
         cMpujv6RRElDCblXp+5ps+0j5x9JE0wmGshs4P5qUWMK8iFph9HatanYnpmbTX+h1UUs
         BMTF+mlaCvU2VxAVz0Fl9PUet1E8YgpewR7Jl98X+H526oDwNwXmCCiFn+XB9wjHxH5C
         H/VVOWStUvKj+7T+0Vpe8x9AtWFOJic5BBm+MwXEEGVgGKC9SN+K7ADQWzooXVlmWLZ8
         cP08QFAT4KlgFfTtAWyyr2V6s4bhU0q7uMcUBtp4G5DuOG15B40hTFIhekIzuW5W3L3R
         pfiA==
X-Gm-Message-State: AO0yUKWZrmCuskRIE302N6QfDigtFESCvOX0lvcH1uiGYPjZuGmUPNze
	m4oxRKIxInNq4eODufj3+jkrko7BHOgsLiz5c/Q4hDh+ltieClgTWJ0ehAusuxEdHDXVse+YJLm
	56pSMN8tLUljXckuxk+RAdAKLOMzU
X-Received: by 2002:a7b:cbc8:0:b0:3ed:ce6f:e86e with SMTP id n8-20020a7bcbc8000000b003edce6fe86emr4439655wmi.23.1679457191109;
        Tue, 21 Mar 2023 20:53:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set/pklFHJPK1s3H7Nj/36hubkKNHp6iiF9YEUAS5PXVuqL6eNBcwQypgDh4at+q64Y2v3mZ9eQ==
X-Received: by 2002:a7b:cbc8:0:b0:3ed:ce6f:e86e with SMTP id n8-20020a7bcbc8000000b003edce6fe86emr4439644wmi.23.1679457190823;
        Tue, 21 Mar 2023 20:53:10 -0700 (PDT)
Date: Tue, 21 Mar 2023 23:53:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230321234626-mutt-send-email-mst@kernel.org>
References: <20230321215834.225856-1-parav@nvidia.com>
 <20230321215834.225856-7-parav@nvidia.com>
 <20230321181704-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1A39CACD02A2BBD4721DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D1A39CACD02A2BBD4721DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 6/8] transport-ccw: Refer to the vq by its number

On Wed, Mar 22, 2023 at 02:45:00AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, March 21, 2023 6:22 PM
> 
> > > +\begin{note}
> > > +\field{queue_select} was previously named as index.
> > 
> > sounds a bit strange, and \field{} is missing. If you insist I'd say
> > 	in previous versions of this specification,
> > 	field{queue_select} was also called queue \field{index}
> > 
> The field is missing because field index is no longer there.

But it was there. Look what it does, it formats in italics so
it stands out from rest of text, making it clear it is
field name (former one) and not the word "index" in english.

> > 
> > e.g. in blk we have this:
> >   In the legacy interface, VIRTIO_BLK_F_FLUSH was also
> >   called VIRTIO_BLK_F_WCE.
> > 
> > 
> > but I really feel this misses the point, the compat is needed
> > in the struct definition, not split out after usage
> > is described. This is why I proposed just making this a comment in the
> > struct. Why not?
> > 
> Sure comment is good to me too.
> In v0 you specifically asked to add note with example.
> You said "like "Note: this was previously known as QueueNumMax""
> It is hard to guess to write a comment when you mean "Note". :)

That referred to MMIO where it's a table not a listing.
I did not check the generated PDF the point is to make
the note appear near the field and also not damage the layout.
Pls take a look at how it looks in PDF - another option is
a footnote though it's a bit harder for readers to find these
and bad for accessibility. Again I don't think these work in listings,
there we are kind of limited to code comments.

> I will change to comment format.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

