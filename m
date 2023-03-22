Return-Path: <virtio-dev-return-11718-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B9AC6FD1C
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:55:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 99052157EF0
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:55:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9103D986463
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:55:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 81A34986450; Wed, 22 Mar 2023 16:55:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70BD598644E
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Mar 2023 16:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: tHpTDpkpMOaQK7UKD8jSOw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mb1qmqmRE6YuUdB8t2eX/GNDeNSliCmwSoQ9DQTVjLY=;
        b=DCU9hCK6tq38ZLb4bxCV/CiSE6w6grJcXrmJdUpUHS/xjLItMP9gsMdTm+NQFnboAq
         wmfebDDzf1MdNqJjhVuGDBDXYsCqEl04Qbl6SpGPfXlKdZSiRlnKUqurZT51Zu6FHoZl
         VE7vqqrz08v+2QuHv8Mk1NS/bWPDweG1eM247VLZkIOrDXiIt+gpLF655ZN+j4y/SKZ4
         r7MwyvK8bIjJjn/0kZQFiLMiUcTZ1Mxsk2T+cM7nvVFWWqIJ2y8sOZ6LRycd+SWdtogM
         CtLxa4cLXsmawUzNigZGTtt5Q083HY9ba0u4qocnOKbDqjX7ctx4aoAuCvTQXG3wrrgd
         UcrQ==
X-Gm-Message-State: AO0yUKUjTS6Pou/lsMkCPuT5Uj/IsIc0jX5YFzws1Rr9wcoLr0qxpMOx
	kCouXRCQF9iuTMOF9/F0qIY1bbq66/TiGckJ7bGEnnolNZR5cOh94QSlGwKm9320tPPHEB1HAYi
	fgHwE6g7YeYOCfKJ4By88a0PbtixH
X-Received: by 2002:a17:906:4c8b:b0:921:5e7b:1c27 with SMTP id q11-20020a1709064c8b00b009215e7b1c27mr3775366eju.24.1679504138438;
        Wed, 22 Mar 2023 09:55:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set9m6drAY7cASYrjy6EuJWHeMgN3tk7JRja9yzUTCM2ESPREQzGlcRXT4HADCps8QlUtpox/dA==
X-Received: by 2002:a17:906:4c8b:b0:921:5e7b:1c27 with SMTP id q11-20020a1709064c8b00b009215e7b1c27mr3775343eju.24.1679504138192;
        Wed, 22 Mar 2023 09:55:38 -0700 (PDT)
Date: Wed, 22 Mar 2023 12:55:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230322125354-mutt-send-email-mst@kernel.org>
References: <20230321215834.225856-1-parav@nvidia.com>
 <20230321215834.225856-7-parav@nvidia.com>
 <20230321181704-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1A39CACD02A2BBD4721DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230321234626-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548115757F72BB333651C1D8DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548115757F72BB333651C1D8DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 6/8] transport-ccw: Refer to the vq by its number

On Wed, Mar 22, 2023 at 04:52:36PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, March 21, 2023 11:53 PM
> > 
> > On Wed, Mar 22, 2023 at 02:45:00AM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, March 21, 2023 6:22 PM
> > >
> > > > > +\begin{note}
> > > > > +\field{queue_select} was previously named as index.
> > > >
> > > > sounds a bit strange, and \field{} is missing. If you insist I'd say
> > > > 	in previous versions of this specification,
> > > > 	field{queue_select} was also called queue \field{index}
> > > >
> > > The field is missing because field index is no longer there.
> > 
> > But it was there. Look what it does, it formats in italics so it stands out from
> > rest of text, making it clear it is field name (former one) and not the word
> > "index" in english.
> True, but since that field index was written what would it refer to.

Refer how?  \field{} is not a cross reference. It's a way to make
field names stand out to make sure readers do not think
this is plain english.

> Anyway, not important once its part of the structure comment.
> > 
> > > >
> > > > e.g. in blk we have this:
> > > >   In the legacy interface, VIRTIO_BLK_F_FLUSH was also
> > > >   called VIRTIO_BLK_F_WCE.
> > > >
> > > >
> > > > but I really feel this misses the point, the compat is needed in the
> > > > struct definition, not split out after usage is described. This is
> > > > why I proposed just making this a comment in the struct. Why not?
> > > >
> > > Sure comment is good to me too.
> > > In v0 you specifically asked to add note with example.
> > > You said "like "Note: this was previously known as QueueNumMax""
> > > It is hard to guess to write a comment when you mean "Note". :)
> > 
> > That referred to MMIO where it's a table not a listing.
> > I did not check the generated PDF the point is to make the note appear near the
> > field and also not damage the layout.
> Yes, the note is next to the field. I looked in the PDF.
> > Pls take a look at how it looks in PDF - another option is a footnote though it's a
> > bit harder for readers to find these and bad for accessibility. Again I don't think
> > these work in listings, there we are kind of limited to code comments.
> > 
> I was trying to have uniform note for mmio and ccw regardless off struct vs table.

That would involve rewriting MMIO description to match ccw and pci
using structs and not a table :)

> But comment is fine too.
> I will change to comment format for the struct.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

