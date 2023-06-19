Return-Path: <virtio-dev-return-12983-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D58EEB64DB
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:57:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ED7B9C623F
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:57:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E55949864BD
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:57:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D9B829863BD; Mon, 19 Jun 2023 17:57:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6219986428
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 17:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: YCMiSPG7MiGhHGOKR-EIfg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687197462; x=1689789462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwHZZ7wwhMQA3lKajQTdq1PYdZYpPPfzoNjCpqwrcic=;
        b=E2GbmtsHYOFOEHGI1duAoRQS9LjMSNK0hLIt80H2UtHLIVQ9WSbsTwMZHo8V0ncg5o
         6FyBSkKGTBlzfWxeCt4qRjcDWYcKool/zSc+W1mftg5aJaSDhmznEWWNmd1AoRLbql+Y
         H6/t1ntUs1PqWtEQAnkD1HSTIxG8NwND61/YqBZD2wCTXGNjv5bhhsoihY0jXaDfiBeJ
         6IBt4Z8E9u4AmzvYIpWxaDedFrer6jaMyFe84vah+JK6dvqauyCmW3DBkn1KfZQ6uudc
         xEcH9aByZMsVbnGkQEU443a45nnNIxDn5uI1B3+L+3ypbarOzbMwOoAIYqjWrNQpmZe8
         g4rQ==
X-Gm-Message-State: AC+VfDzH0OUwXZFErKFIeKbl6Fng39jKw8nnWh6F/N0Py1kSv8FagAgh
	MV5j9TqY8ioA+Z88GzKQkZu02fFSTE9WttHs0Gr+hwLbs+Ud58oOz0/wHyxjjVZGeCWIAzkpIVx
	1u4swXsZK1kAlQ7/bIUmDFaJVwFFc
X-Received: by 2002:a5d:68d0:0:b0:30f:c008:a921 with SMTP id p16-20020a5d68d0000000b0030fc008a921mr8285212wrw.17.1687197462403;
        Mon, 19 Jun 2023 10:57:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JGu7epeNB7k0q3Fep7rLSWUkEREGHXR1ZOK7aQANtnNp1YlBrDqbh/35nvUyWh4MGPdxZxA==
X-Received: by 2002:a5d:68d0:0:b0:30f:c008:a921 with SMTP id p16-20020a5d68d0000000b0030fc008a921mr8285197wrw.17.1687197462060;
        Mon, 19 Jun 2023 10:57:42 -0700 (PDT)
Date: Mon, 19 Jun 2023 13:57:37 -0400
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
Message-ID: <20230619134649-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access

On Mon, Jun 19, 2023 at 05:45:17PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, June 19, 2023 1:38 PM
> 
> > > > If we can't just make it come for free then maybe
> > > > VIRTIO_PCI_CAP_LEGACY_NOTIFY_CFG is better, we can just list the
> > > > number in the common section and then link to the description in the new
> > section.
> > > >
> > > How is it better? It requires burning more bytes.
> > > Is it better because it is self contained?
> > 
> > Mostly yes. But it also adds a bit more flexibility, right?
> > I thought avoiding touching transport-pci is worth less flexibility but if we can't
> > avoid that...
> >
> That flexibility is better gained via AQ instead of introducing new extended capability on the VF.
>  
> > 
> > > > I also feel we want ability to have such a capability in the owner too.
> > > > Would prefer including it now though I guess we can add it as an extension.
> > >
> > > Re-opening the past discussion.. amazing. :)
> > 
> > OK fair enough.. I guess both of us are not 100% happy but it's a compromize
> > for now. And maybe we'll add one of AQ and / or PF cap down the road.
> > 
> > > Why? How is it different and better than querying over AQ?
> > 
> > Wait a second let me clarify. I am talking about notification in the PCI BAR of the
> > PF. *Not* offset in PF capability but in the VF BAR.
> > 
> Ok. question remains the same, why not discover such notification capability it over the AQ command?
> AQ command on the PF is self-contained and extendible without baking things in very low level hw centric pci capabilities, which are hard to get rid of it.

I worry about systems where there's value in having VF driver
map memory without talking to PF driver.
Current VF capability is kind of ok I guess ...

If you want admin command to query then it would need
to map in PF memory.
I understand two concerns with this:
- you worry that this forces ordering requirements - it's true and I
  don't know of a good fix. So if possible use VF BAR by preference?
- you worry about wasting physical memory space
  this we can fix by sticking VF# in the kick.

As an alternative, if we can make the new command
able to communicate offset in PCI BAR or in VF BAR
or both then I think that's also an acceptable compromize:
drivers that have trouble mapping VF BAR after querying
PF can just map PF BAR. WDYT?


> > 
> > > I see the AQ is better than group owner and group member specific cap.
> > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

