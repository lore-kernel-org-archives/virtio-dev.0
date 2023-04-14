Return-Path: <virtio-dev-return-12235-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303ECC77B6E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 06:58:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 71E093E305
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 06:58:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61CE298660E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 06:58:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5486B984140; Fri, 14 Apr 2023 06:58:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 456A1986600
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 06:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ANNDxPZnMB6K7Rh6OlgEzQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681455520; x=1684047520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHEX4l8Rx4cJOA1cgiftIrz5zP0GW3oXIlwuB/sAdJ4=;
        b=YBoJfac+85d7yyJKzc5VHyHqRfJ4rgpfzREMwrtrpP10iOa8f8EaTO0aEqkXj2KeEA
         QHPbMcwgbtVswdCw3CcUO+Nln2omWiI4oaGD81UOcT/JtCKCK1cYtnFSZ1H92mFVcGjR
         q4DMNOM8KJEdrBcNqcsqlqn+DR3Lp4MuclFcHWow51t1VaXJpIiLzbghtXl12E0pSg0G
         sT4o6vl6NAB9zDDPOE/4iajlm3iwDFJzawkv9UT1rpbtVKEN3WAh4YN7IHE+0RQOIqGK
         Yt+m8SI3PIdG3qp5B/Iw/5RtutUg77a5Tbgo+wW3dEHMQ5qY2SYI5okNsG7Gjzt27l6A
         MVCg==
X-Gm-Message-State: AAQBX9fr1kAT3TXJcqcWwkUkXZrtClmZRB24Fkdwn3lf//Kbf0VGs3Pt
	GfvEgTx6tng4qjIlpnqIN6q4MyxfDKOsU7HHqDxOFqvEsF8Xx1OdxV9KbWRLq2tPoOVndu8Sn9z
	Nc4gPWhZ1b/o2rXlpZgBf1/2NGFqb
X-Received: by 2002:adf:ea08:0:b0:2f6:4a39:9701 with SMTP id q8-20020adfea08000000b002f64a399701mr2879344wrm.41.1681455519937;
        Thu, 13 Apr 2023 23:58:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350aNG6ILnP7C2GETPKj7vQitnlFOoQa59SPn7oz8i7s7vkS+ZuRYnaXVhSWAMGRgRwPDmYOLCQ==
X-Received: by 2002:adf:ea08:0:b0:2f6:4a39:9701 with SMTP id q8-20020adfea08000000b002f64a399701mr2879327wrm.41.1681455519651;
        Thu, 13 Apr 2023 23:58:39 -0700 (PDT)
Date: Fri, 14 Apr 2023 02:58:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Yan Vugenfirer <yan@daynix.com>
Message-ID: <20230414025726-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
 <20230413163216-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Fri, Apr 14, 2023 at 10:36:52AM +0800, Jason Wang wrote:
> On Fri, Apr 14, 2023 at 5:08 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, April 13, 2023 5:02 PM
> >
> > > This thing ... you move some code to the card and reduce the amount of virtio
> > > knowledge in software but do not eliminate it completely.
> > Sure. Practically there is no knowledge other than transporting like a vxlan encapsulating, here its AQ.
> >
> > > Seems kind of pointless. Minimal hardware changes make more sense to me, I'd
> > > say. Talking about that, what is a minimal hardware change to allow a vdpa
> > > based solution?
> > > I think that's VIRTIO_NET_F_LEGACY_HEADER, right?
> 
> I think it is. It would be much easier if we do this.

It does not look like Parav is interested in this approach but
if you like it feel free to propose it.

> >
> > The main requirement/point is that there is virito PCI VF that to be mapped to the guest VM.
> > Hence, there is no vdpa type of hypervisor layer exists in this use case.
> 
> It's about mediation which is a must for things like legacy. If
> there's a way that helps the vendor to get rid of the tricky legacy
> completely, then why not?
> 
> >
> > This same VF need to be transitional as the guest kernel may not be known.
> > hence sometimes vdpa sometime regular 1.x VF is not an option.
> > Hence for next few years, transitional VF will be plugged in into the guest VM when user is using the PCI VF devices.
> 
> I'm not sure I get this. With VIRTIO_NET_F_LEGACY_HEADER, we don't
> need mediation for datapath. For the control path, mediation is a must
> for legacy and it's very easy to keep it work for modern, what's wrong
> with that?
> 
> Thanks
> 
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

