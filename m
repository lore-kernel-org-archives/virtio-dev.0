Return-Path: <virtio-dev-return-13167-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C1BEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:45:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 795623894
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:45:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5444F9866F5
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:45:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3A411986677; Thu, 29 Jun 2023 21:45:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25F6A98667F
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 21:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: eSnb92UQO_-WSXNWd3zenQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688075150; x=1690667150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABJ/ENovWQ9lXDTK1wb0snT5cMR3gtOt5/Wair1MiiA=;
        b=DPdrtMOHesvFmaSEgw0f44eGBEu6PUJhtJhv4JSkO4gVxLovSm2nhj5imqLinBlsLp
         7CyDUnM3+Y8H37h5YoYh9bpXq1BWR4y+l/V8/bsSRKdo8HLzfOpMRoOrAN/o37Z4eO5q
         EVUNsjlRoFDlFkWQBY0WZzVjm+3iQqKfDyhVObsdLmcWdpoz9RrFbWlCHE1aN09OWJm9
         2bPjZDCyGAo+aZ7TkLX/iNcqFu9qmXpnIo/fG2p56nRjEMNilqckZw7mBw5+gcsziTt2
         GYl+nlLkNDqzRa1EexUJBMlvxnVnuzhz8Uplpca202tpjqEyLU5SJlckvW0pT7gLSpRw
         dgZw==
X-Gm-Message-State: ABy/qLaxI4PmmBcbSGFRyNNofNdhf8nOFvAYkKoeFU5mBnKdcsIacjK+
	5r4NsIFkZ3SrcFxlc4sfWcXYewAYDp7iBmpnr7O/VmKjOqc+b/+tYjmvYrLh8LWPh5o6Op3zu71
	H3U8ue3y+7pWSUVlVsy0dD7vEn8uA
X-Received: by 2002:a5d:6581:0:b0:313:f463:9d40 with SMTP id q1-20020a5d6581000000b00313f4639d40mr497690wru.65.1688075150731;
        Thu, 29 Jun 2023 14:45:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEveRmxTSfhf81ZZ6JwRyj59V/zOUVAYAttaGqMGKTq1DaBunAK+VoiHnZMnhwiSUpm2iZUoQ==
X-Received: by 2002:a5d:6581:0:b0:313:f463:9d40 with SMTP id q1-20020a5d6581000000b00313f4639d40mr497681wru.65.1688075150435;
        Thu, 29 Jun 2023 14:45:50 -0700 (PDT)
Date: Thu, 29 Jun 2023 17:45:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230629174443-mutt-send-email-mst@kernel.org>
References: <20230627211050.1527507-1-parav@nvidia.com>
 <20230627211050.1527507-4-parav@nvidia.com>
 <20230629154634-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E7610F4941C615617CA0DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E7610F4941C615617CA0DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v7 3/4] admin: Add group member legacy register access
 commands

On Thu, Jun 29, 2023 at 09:32:21PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, June 29, 2023 3:50 PM
> 
> > > +When command completes successfully, \field{command_specific_result}
> > > +uses following structure:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_legacy_notify_query_entry {
> > > +        u8 region[8];
> > > +};
> > 
> > This confuses more than it clarifies.  Do this:
> > 
> I rename region to region_data and link for the transport.
> Mostly implementer will directly jump after learning this theory of operation so, it should be ok to list in pci.
> 
> > struct virtio_admin_cmd_legacy_notify_query_entry {
> > 	union {
> > 		virtio_pci_notify_region region;
> > 	};
> > };
> > 
> Yes, I thought about it, but it was pci transport listing so kept it generic.
> More below.
> 
> > 
> > > +
> > > +struct virtio_admin_cmd_legacy_notify_query_result {
> > > +	struct virtio_virtio_admin_cmd_legacy_notify_query_entry entries[];
> > > +}; \end{lstlisting}
> > > +
> > > +The driver should pick the suitable entry when multiple entries are
> > > +supplied by the device.
> > > +
> > > +Refer to the specific transport section for the definition of the
> > > +\field{region}.
> > 
> > Where? How does user know where to look?  Add a link.
> >
> Will add the link.
>  
> > 
> > Or preferably I would just include that tex right here to avoid the need to jump
> > back and forth.
> > 
> We have vq notify config data as generic and transport specific listing,

But note how that is included directly in multiple places -
not a link. In the resulting PDF it appears inline.

> So will improve this part of text with link.

anyway, that's not part of ABI.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

