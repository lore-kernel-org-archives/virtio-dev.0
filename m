Return-Path: <virtio-dev-return-12496-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34344C77B7E
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:36:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9BBB6120D49
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:36:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D75B98649D
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:36:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8192B986479; Tue,  2 May 2023 11:36:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FACB986486
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 May 2023 11:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4VQlhKX6MVSCbcq5ywQ71g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683027398; x=1685619398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75sjQBjjcI4N9r5kl0oLyqt9yBSGWOgXVFhXmo2dA3M=;
        b=AjM5oIhBV3Y8hmnQeLKygrCnCbMFpWskeQH2wEWCxEEj4HGbXhrfcw6fsBwoDphrvk
         ILbZIRxwz4ji+nLHf2MH7IBLAoQssSVRDzoOqyZ1tJKmK0k7bI6RNlDwyBbQRmoqc6xz
         G5sEHUI8H8KVxPegF8vBFLfRCU7IVOIXaKsbCy7bbZp+iF80737J1qXNcT1SYCAk6m2i
         32kZUrqSUp2Al8BMoUQGc1lNxT401mBXdca3ST5R5Uh+miWfc64wY+gcqFDIc4BHnHdZ
         d+OU5R5Il49SsHznbl0OVWZtnuMWRzPbeW0qcELs2MUuqJD/mSllhQVSHRAcjOg57841
         0rjw==
X-Gm-Message-State: AC+VfDxmSuqu/x98dASEq3s1ZhDsbMprVZ3n248c2IhA/ErNwdgQiB+D
	pQ41SiwWp2hPydkHSfVQUWmSBOgnKX8M5GbawK0AoQfVX4Ibd0ZrPC19ZG2yFrOVxe6GXCY3I8r
	YzYEfRJC4JUv+96rFZMAlOI6btwcO
X-Received: by 2002:a05:600c:1e1e:b0:3f1:89de:7e51 with SMTP id ay30-20020a05600c1e1e00b003f189de7e51mr303103wmb.12.1683027398636;
        Tue, 02 May 2023 04:36:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Q84mtb9LfEd5Rlp15AteppJodzkQINJzQwt1gaRbuXE9ExYfAv6ILAhfHTSLb9zpz54yKsg==
X-Received: by 2002:a05:600c:1e1e:b0:3f1:89de:7e51 with SMTP id ay30-20020a05600c1e1e00b003f189de7e51mr303088wmb.12.1683027398313;
        Tue, 02 May 2023 04:36:38 -0700 (PDT)
Date: Tue, 2 May 2023 07:36:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230502073506-mutt-send-email-mst@kernel.org>
References: <20230501224430.485139-1-parav@nvidia.com>
 <20230501224430.485139-3-parav@nvidia.com>
 <20230502033510-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813C5953966EAAB740C882DC6F9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813C5953966EAAB740C882DC6F9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 2/2] admin: Make optional command data type to u8

On Tue, May 02, 2023 at 11:29:03AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, May 2, 2023 3:38 AM
> > Thanks for the patch. It was like this originally but readers were confused.  The
> > point of marking it le64 is to make it clear it's size is a multiple of 8 bytes, thus
> > 64 bits. And format of fields inside it is generally LE.
> 
> If it is supposed to be le64, the result should be same data type too, isn't it?

Oh. Good point. Will fix.

> > 
> > > ---
> > >  admin.tex | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/admin.tex b/admin.tex
> > > index 037e2e6..648253c 100644
> > > --- a/admin.tex
> > > +++ b/admin.tex
> > > @@ -85,7 +85,7 @@ \subsection{Group administration
> > commands}\label{sec:Basic Facilities of a Virti
> > >          /* unused, reserved for future extensions */
> > >          u8 reserved1[12];
> > >          le64 group_member_id;
> > > -        le64 command_specific_data[];
> > > +        u8 command_specific_data[];
> > >
> > >          /* Device-writable part */
> > >          le16 status;
> > > --
> > > 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

