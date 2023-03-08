Return-Path: <virtio-dev-return-11499-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30786C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 05:12:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7B88A23D70
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 05:12:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 746D09866EF
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 05:12:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 690BD9866E3; Wed,  8 Mar 2023 05:12:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 520299866E4
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 05:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: k0FUcZkKMEq2_epG5x4hqQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678252320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwmZ+iZtOdb6xtS6VlyABxn6D/524+YuO6ugnk+rC10=;
        b=rSDbUbmBSX068DvDlAWq82GEmmFNMqzI8Zcr/K5kKEihqNIKhilFb/09X0wbHlkjrE
         giIyNGXzUdRB9NJ7etNRgkw3BZIa+HGKImHgV4MgvNQG+4gwPDwUvFDsan0DMkK7hBtA
         8S1ovg+KpHYzaPdQVCUWnkG7UA1rCzzye3e2YtsOZZt76kfiR72QfzGMb5Rq2t70n4dx
         r0IfYBTvJJBONuZ1uAxHhKaCA3lWliqCHbWxNMEEK7fSlom5F07AA4pravI45PlVXZGV
         kEIKUFFAgtjzs5nBImPdJifViHxuZXG4tyuWSnqGrizzubRmU+S6tpYlqgjk7Dxc0KoB
         et1A==
X-Gm-Message-State: AO0yUKXgRuKYU4u/fysKzTEvdClZCdHKF9GOZ/Dg9K73lcimRD4wN8kI
	RdF8adoce/PeCyprUtE06uOFpTftjPGWQlq7X+5rjwiBEMLE0l8PuUfLIuLPW90thnx+NCSiVut
	fnDLqU8RccX7uT54V5Oc3RGNtQVTDIZzMJ6OZfP61doWF
X-Received: by 2002:a05:6808:45:b0:384:27f0:bd0a with SMTP id v5-20020a056808004500b0038427f0bd0amr5009614oic.9.1678252319916;
        Tue, 07 Mar 2023 21:11:59 -0800 (PST)
X-Google-Smtp-Source: AK7set+Hrc4fQyZgiEedKCp6yyMIuRIL22TGJhNBpisAmiv7XLs417J2YqruFfjuiio9qMhogLdl7+GQmv54WHYsljg=
X-Received: by 2002:a05:6808:45:b0:384:27f0:bd0a with SMTP id
 v5-20020a056808004500b0038427f0bd0amr5009608oic.9.1678252319659; Tue, 07 Mar
 2023 21:11:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677761896.git.mst@redhat.com> <ZAXcqqdwfoLokT2l@nanopsycho>
 <20230306175020-mutt-send-email-mst@kernel.org> <ZAbmEmwsMMxKJqeB@nanopsycho>
 <20230307121529-mutt-send-email-mst@kernel.org> <PH0PR12MB5481EEF6CD4B946233EE311FDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481EEF6CD4B946233EE311FDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Mar 2023 13:11:48 +0800
Message-ID: <CACGkMEtxRWguwC0SgZ5wDDpcyw08r3GAD2=BP=Y88yMXZQ-FNQ@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, 
	"hang.yuan@intel.com" <hang.yuan@intel.com>, 
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, 
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management

On Wed, Mar 8, 2023 at 3:31=E2=80=AFAM Parav Pandit <parav@nvidia.com> wrot=
e:
>
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, March 7, 2023 12:20 PM
>
> [..]
> > > >For SR-IOV, it is not unusual for PFs to excercise control over VFs.
> > >
> > > I understand the concepts of SR-IOV. Yet I fail to see the need of
> > > such concept in virtio world. SR-IOV is very specific solution for PC=
I
> > > functions instantiation, and I believe that it is already considered
> > > quite limiting in many aspects. Does not make sense to me to introduc=
e
> > > it for virtio. But again, I may be missing something crucial, I just
> > > would like to see the motivation, needs, usecases for this crystal
> > > clear, which is opposite to the current cover letter I'm afraid :/
> >
> > First people are asking for it because it's out there, however limiting=
 it is. In
> > fact Nvidia is - why don't you talk to Parav here and tell him that SR-=
IOV is
> > legacy and there's no need to support.
> >
> Jiri and I discussed offline today.
> SR-IOV is widely used today and in the coming future up to thousands of d=
evices.
> Many vendors are building it or already built.
>
> SIOV as it stands today is still being crafted at various levels iommu, o=
s, device, pci and more.
> Not there yet fully.
>
> Jiri and I built the Linux kernel interfaces for SFs which are equivalent=
 to SIOVs that overcome some of the SR-IOV limitations.
> And Jiri's suggestion was to leverage some of the vision and practice fro=
m there.
>
> In other words, can AQ command be useful tomorrow for doing SIOV device a=
dd/remove, and provisioning from non-owning PF?
> The way AQ is crafted today is not there yet, but in the future, it can b=
e extended.

There's already a proposal to use the queue as a transport. Any device
that can't use a transport specific configuration or provisioning can
benefit from that. SIOV is only one of the users for that.

> >
> > >
> > > >There is interest in the community to include an interface to allow
> > > >this in the virtio spec, when the PF is a virtio device.  This is
> > > >what this patch does.
> > >
> > > Yeah, but why? As I asked before, what are the usecases? The fact
> > > there is interest in the community does not mean it makes sense to
> > > have it :)
> > >
> >
> > If people want to build such hardware it will need some interface.
> > Far better to have it standard.
> >
> >
> > But generally e.g. intel already said they will reuse this same structu=
re with a
> > different group type for SIOV support.
> > I'll mention this in the cover letter.
> >
>
> We have the following already identified use cases of a device agnostic V=
Q.
>
> 1. SR-IOV VF device provisioning at virtio layer (features and config)
> 2. SR IOV (SR-PCIM interface of the PCI spec) for VF provisioning, for ex=
ample, MSI-X vectors
>

The virtio layer device provisioning is transport independent. I don't
see anything that is PCI specific there. Even the MSI-X could be
reused by other transport.

> 3. SR-IOV VF Live migration

I think we don't want a partial solution for live migration that only
works for PCI VF devices and L1. Instead, there needs to be a general
device facility section and the admin virtqueue could be one of the
interfaces for the driver to use the facility.

> 4. Above #1 to #3 for SIOV devices instead of SRIOV devices

If we make the above as a general facility, it would not be hard to
re-use them for transport virtqueue or SIOV.

Thanks

>
> 5. cmd q interface for PF/VF/SF/SIOV to transport their own features, con=
fig command over queue interface without any parent device
>
> #1 to #3 are well described in past. So, It is worth covering them in the=
 cover letter and things will be clear for new eyes.
> #4 is broad use case and like #1 to #3 that will eventually happen.
> #5 likely needs more discussion, we can differ to a later point because A=
Q needs to progress in spec 1.3.
>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

