Return-Path: <virtio-dev-return-12051-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763EFC6FD1D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 08:15:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 953702B046
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 08:15:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87BA59865D8
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 08:15:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 741A9983F7B; Fri,  7 Apr 2023 08:15:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63B4D9865D7
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 08:15:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: vHKfv47FMLO4uLsqwsyhAw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680855325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt9FyPmEqPlSCNAf6SuLxf/NsgJHq0ZXI9diWvSfh6s=;
        b=RqLtwqmJbRaxOtF1WzSDyWFwd1qX6G6fg5G7F+n6ffoy9IYt+g4SExPMa93kqAimDu
         swJbPQC5UgYoPn67YI1U0YqsGqa5M4lIpsVs94s5z/U2Fzv1S962nPeG/lK7IphfWeH0
         7VD7Sb7fWDulTpm+SDWSEqeO433LKPukcs9pdqfZrXlEKlj1URbcS8fOLY7Vbh3BK4Ie
         Lox+vaZg5sNyCNucLD/0o+uKjvTT2mNRtfo3qZ1tHociqos9sDk1FMnM3i+KHn3Wmo7+
         KBk2dlyVUx8B/znS1M4XyMqJp07QizBYz7/0nnzL6e33KwO33/0ielX1gFQl+5MdpK9L
         TnRw==
X-Gm-Message-State: AAQBX9ewgaUGsBVh5YjInL5Y8SrXNPO3JfiZqrDXbt08TImAng7D31wD
	uUDcO6g3cEi2ADKeDHHLuPC7RL+zSTb/0QcoFVwssKrbF79T5GtZouPtDplXLiLHAOpZiY08vHX
	scdk9bkxWN+w5QE1Dy4WZZE4x2JXD
X-Received: by 2002:a7b:ce16:0:b0:3ee:2b04:e028 with SMTP id m22-20020a7bce16000000b003ee2b04e028mr951025wmc.14.1680855325121;
        Fri, 07 Apr 2023 01:15:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zz4iVZsIXBH2ZmcEdewZ7JM7wSnvYfjozA/xBwyAY5RiMbnpTU6tS7dwDzYDIWgf1YsmDFCw==
X-Received: by 2002:a7b:ce16:0:b0:3ee:2b04:e028 with SMTP id m22-20020a7bce16000000b003ee2b04e028mr950992wmc.14.1680855324682;
        Fri, 07 Apr 2023 01:15:24 -0700 (PDT)
Date: Fri, 7 Apr 2023 04:15:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230407041000-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548157060FCDB5B38CA63C8ADC939@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230405010807-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B5F4F8797F0F795E7794DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B5F4F8797F0F795E7794DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Wed, Apr 05, 2023 at 01:16:31PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, April 5, 2023 1:11 AM
> 
> > > > > +struct virtio_pcie_ext_cap {
> > > > > +        struct pcie_ext_cap pcie_ecap;
> > > > > +        u8 cfg_type; /* Identifies the structure. */
> > > > > +        u8 bar; /* Index of the BAR where its located */
> > > > > +        u8 id; /* Multiple capabilities of the same type */
> > > > > +        u8 zero_padding[1];
> > > > > +        le64 offset; /* Offset with the bar */
> > > > > +        le64 length; /* Length of the structure, in bytes. */
> > > > > +        u8 data[]; /* Optional variable length data */
> > > >
> > > > Maybe le64 data[], for alignment?
> > > >
> > > It gets harder to decode (typecasting ..) if its string with le64 data type.
> > 
> > In what language? In C you have to cast anyway, string is char *, often signed,
> > not u8.
> > 
> > > I will extend the comment,
> > >
> > > +        u8 data[]; /* Optional variable length data, must be aligned
> > > + to 8 bytes */
> > 
> > I'd keep it le64 or u64, it is highly unlikely we'll pass strings through this
> > interface anyway.
> 
> Ok. will change.
> 
> What about rest of the patches? If we proceed using MMR interface, rest of the patches are fine?

Biggest problem is 7/11 - the new IDs, breaking all existing drivers.

I thought I replied on that but don't see it on that specific patch.
Let me repost my thoughts now I had time to think it over.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

