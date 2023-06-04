Return-Path: <virtio-dev-return-12849-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AFCC7EE29
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:47:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4002FF936A
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:47:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27D7B986332
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:47:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 083B39862CE; Sun,  4 Jun 2023 14:47:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E92E79862D0
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Jun 2023 14:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 552PbYE-NGSnGpoO8lpBRw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685889718; x=1688481718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGoKXEYBF8QNuZML8Ld/jUOVb9LNcG9yF771Q+C71YA=;
        b=eXSLuIu+ZT1IRwdTLiG9UKaikeFWaAMMOYuVWxu91y1opgwBoIfp/pzFq/vxOpFp4t
         /pHqUNyB1gHQ2ZWyVdOhGFtwQySbetuxf/ZWRmV1QbKSU73GIJrU/52OSnEjS1oBZkgC
         GxVOcQNURIITntQFag6toiNA6DQTL799IY0e4vLOLW37ZyOoRj4rMzjOq6hOM3o+g9fN
         zMGFjtVuhrD+E9MQPfYXeWqH7hkdK0F0m2/PWrUFgxz8DqjweVzykqcQiDhPWW2+3Fp/
         WDrYRDkCWLMJMmEV3bHJhr8byP9zm1WeBPxc2BjZjq7pbpKVElL0GKM9VlTbFw5plcHp
         JZlA==
X-Gm-Message-State: AC+VfDzLxPj+BNrrSzwT2CBDwL6XkHgYS5HtvnZIdp+aoLlg5VHwKkrY
	YzhYqREdF+YfF3hsTw43BotKNxotDP/Z5Qf68fKaT6cz9xQ0ZoxbvXIHrjKcdzvkggLZ3gyCMPD
	HRhpCzIUm2u5Ba0t/aVcAe4ApQQHC
X-Received: by 2002:a1c:7911:0:b0:3f6:8ca:ed52 with SMTP id l17-20020a1c7911000000b003f608caed52mr4593434wme.34.1685889718549;
        Sun, 04 Jun 2023 07:41:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+WrlXTuZfmOsY2AGCuGBVcNKzE9LMAHlHEWdpw2TXlOlMZFSVnZjDaUM7lkF6jlBydatOxQ==
X-Received: by 2002:a1c:7911:0:b0:3f6:8ca:ed52 with SMTP id l17-20020a1c7911000000b003f608caed52mr4593420wme.34.1685889718076;
        Sun, 04 Jun 2023 07:41:58 -0700 (PDT)
Date: Sun, 4 Jun 2023 10:41:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230604103309-mutt-send-email-mst@kernel.org>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230602203604.627661-3-parav@nvidia.com>
 <20230604091651-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481195B63FD61C35447FFDFDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604095615-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D7C7EEAC610BBBDEB69ADC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D7C7EEAC610BBBDEB69ADC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands

On Sun, Jun 04, 2023 at 02:32:23PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, June 4, 2023 10:14 AM
> > 
> > On Sun, Jun 04, 2023 at 01:51:20PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Sunday, June 4, 2023 9:22 AM
> > >
> > > > > +The driver that may use the driver notifications region of the VF
> > > > > +device returned in this result likely attain higher performance
> > > > > +or the drier may use the VIRTIO_ADMIN_CMD_LREG_WRITE command.
> > > >
> > > > Obtain I guess ... but how? There's no explanation.
> > > >
> > > Do you suggest to rewrite, above as below?
> > >
> > > The driver that MAY use the driver notifications region of the VF likely obtain
> > higher performance.
> > > The driver may use VIRTIO_ADMIN_CMD_LCC_REG_WRITE command for
> > doorbell notifications.
> > 
> > No this does not address the issue that there is no description of how this
> > command is used just a hint at what it returns. 
> 
> > So this gets us some offset into
> > some bar now what?  
> > I am guessing writing vqn at this offset into bar has the
> > same effect as issuing VIRTIO_ADMIN_CMD_LCC_REG_WRITE with offset 16
> > and data including the vqn?
> > 
> I can add the one line description that describes above. I take note for v4.
> 
> > 
> > BTW all these may/must/should need to go into conformance section.
> >
> Conformance section for the AQ itself is missing. And I am aware to fix it post your v13 series.

Hmm missing where? It was supposed to be added here:

commit bf1d6b0d24ae899d08c7cf24ed480cf5881c49ef
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Sun Nov 20 19:43:45 2022 -0500

    admin: conformance clauses

what did I miss?   


> > Generally the way we structure the spec is an explanation of the theory of
> > operation (mostly missing here)
> >
> It is not any different from v2.
> Theory of operation is not going to describe the whole driver design.
> It is not likely the scope like any other section.
> Section "Legacy Interfaces: SR-IOV VFs Registers Access" has theory of operation described and also in commit log.
> 
> This is like recent AQ patches and notification coalescing and more.
> 
> So if can pin point what exactly you want to see in theory of operation, it will be helpful.
> Because for one person, 10 lines of theory is enough like how we have most of the spec, another wants 100 lines with pseudo code in appendix.

yes but I think this assumes a bit much. you start by saying there's no
IO BAR. Okay, it's not even mandatory to give motivation, but can't
hurt. The next step is you describe a bunch of commands. Presumably
the reader will draw the conclusion that they replace an io bar?
But it's implicit, and that is not good.

So, I imagine we have a driver that translates legacy accesses
to AQ commands, yes? And it also somehow uses the extra
command to get an address and then translates notifications
to writes at that address? This kind of thing is what
I called a theory of operation.

A couple of paragraphs.



> > v2 had other issues so I missed this one.
> > 
> > > But ok.
> > >
> > > No. It is not related to last command.
> > > What does a PCI Device use BAR for?
> > 
> > To reserve address space and know which addresses to claim.
> > 
> > Generally if I heard "not use BAR0" I would assume that the meaning is that VF
> > BAR0 in SRIOV expended capability should be 0. However, that affects all VFs
> > and not just this VF so I don't really know what can it mean.
> >
> A PCI PF and VF device which wants to support legacy emulation should not expose BAR 0 in the struct virtio_pci_cap struct.
> Instead it should use other BARs.
> 
> > > As described in the spec, it uses the BAR in struct virtio_pci_cap for exposing
> > various things.
> > 
> > Now I'm confused.
> > So do you mean the \field{bar} in virtio_pci_cap or PCI BAR?
> >
> Yes.
> > > So it means that PCI VF should use other than PCI BAR 0 for various Virtio
> > Structure PCI Capabilities that it exposes.
> > 
> > I suspect you then want to say "should not expose to driver any structures
> > inside it's BAR0"?
> Instead of bisecting at structure level, it is indicated on usage so that it doesn't need to bisect on "what about MSI-X".

But what is the answer?

> > And does this include this new command you are adding or not?
> > It mentions bar too.  What about e.g. MSIX tables? Could there be other
> > capabilities referring to a BAR? 
> 

?

> > How does hypervisor know whether VF followed
> > this rule (it's a should, not a hard rule after all)?
> > 
> It is not a MUST.
> Hypervisor software using this VF very easily know this when VF is attached to the hypervisor driver by reading the capability.

which capability? E.g. there's a vendor specific capability we don't
even know what's in there. If you really want to save code in
the hypervisor this "should" is pretty useless.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

