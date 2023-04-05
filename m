Return-Path: <virtio-dev-return-12000-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F56C7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 05:10:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B4D5C2A88E
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 05:10:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67E489865BD
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 05:10:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 55DD0983DE1; Wed,  5 Apr 2023 05:10:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36C1598666B
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 05:10:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: IyzgypKtNP-hfQIoQfaxvg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680671435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDaXPugbO4ssbTj+DknnyCXmE0fPbNV5AsIwqAIam5w=;
        b=vnKXbtqAIv/y8UCqKlA120c6kVjuVOB9t8KaClYrMT55wqJXogkGDJNCxpdzP+JssV
         lxfruVWr8wVfDnurukzXj2DhFJOsZkQ8qhv2ZlnWVMV9kyT/g3ltL4sfmCIgpqPK6DND
         e0aTIBD9OFAwxVo5U+L//9tnefegbg5HE/ZYj1GzewzKLI1U8PCu+d8lfYb5Z3np4QAg
         9bYRTSeTlEEv8CEaSWFiXonegzP7SZtK9THGSSFntckeo/CAUBh3U89qFVCq44NRyGq8
         mscJZBQxF5RavOX86lmYu2RRUeACGxqR3UXsRvC3jCPlKeilSM03o1XLa8uAbnKzaPA0
         U8Bg==
X-Gm-Message-State: AAQBX9c1HzZbH1yvnF9Z2Xe9Js8aM+FVLTN1pHi5uHjR9qRAoukLMdM4
	EwhkmFVie3nZCkFrfJi9FOhe85lm4kaFg7lD0MEJ1QVJetgW2PgPaikNQ2+gEmDz5QcQ19aDjrS
	VUgxl/BLr0C7J+PCUzaMIoRtxL7y8
X-Received: by 2002:a17:906:6c86:b0:932:e141:29c7 with SMTP id s6-20020a1709066c8600b00932e14129c7mr1545553ejr.19.1680671435286;
        Tue, 04 Apr 2023 22:10:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350aC9kNarE45p5JPnZmYzFxZrDwFttWhBwp59QkEvl4p5nCqciqq4Gm/7fjCNlm1yf/KBwbfMA==
X-Received: by 2002:a17:906:6c86:b0:932:e141:29c7 with SMTP id s6-20020a1709066c8600b00932e14129c7mr1545537ejr.19.1680671434940;
        Tue, 04 Apr 2023 22:10:34 -0700 (PDT)
Date: Wed, 5 Apr 2023 01:10:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230405010807-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548157060FCDB5B38CA63C8ADC939@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548157060FCDB5B38CA63C8ADC939@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Tue, Apr 04, 2023 at 09:18:53PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 4, 2023 3:35 AM
> 
> > > +Virtio extended PCI Express capability structure defines the location
> > > +of certain virtio device configuration related structures using PCI
> > > +Express extended capability. Virtio extended PCI Express capability
> > > +structure uses PCI Express vendor specific extended capability
> > > +(VSEC). It has a below
> > 
> > a layout below, or the following layout
> > 
> Yes. somehow it got trimmed.
> Will fix it.
> 
> > > +layout:
> > > +
> > > +\begin{lstlisting}
> > > +struct pcie_ext_cap {
> > > +        le16 cap_vendor_id; /* Generic PCI field: 0xB */
> > > +        le16 cap_version : 2; /* Generic PCI field: 0 */
> > > +        le16 next_cap_offset : 14; /* Generic PCI field: next cap or
> > > +0 */ };
> > > +
> > > +struct virtio_pcie_ext_cap {
> > > +        struct pcie_ext_cap pcie_ecap;
> > > +        u8 cfg_type; /* Identifies the structure. */
> > > +        u8 bar; /* Index of the BAR where its located */
> > > +        u8 id; /* Multiple capabilities of the same type */
> > > +        u8 zero_padding[1];
> > > +        le64 offset; /* Offset with the bar */
> > > +        le64 length; /* Length of the structure, in bytes. */
> > > +        u8 data[]; /* Optional variable length data */
> > 
> > Maybe le64 data[], for alignment?
> > 
> It gets harder to decode (typecasting ..) if its string with le64 data type.

In what language? In C you have to cast anyway, string is char *, often
signed, not u8.

> I will extend the comment, 
> 
> +        u8 data[]; /* Optional variable length data, must be aligned to 8 bytes */

I'd keep it le64 or u64, it is highly unlikely we'll pass strings through
this interface anyway.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

