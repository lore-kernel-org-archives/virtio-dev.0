Return-Path: <virtio-dev-return-11534-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10ADFC678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 15:05:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4C0882B146
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 15:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id 38D092ACE8; Wed,  8 Mar 2023 15:05:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3CBDD9866F0
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 15:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: SO9kk2EqOIGs9HSgXQrMuA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678287851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOm5iLTyvYuZkGNifsVKGabJV5p81xvJ7XKXqE55NuA=;
        b=vizK4/uTopD9MRQSopWpZNolZXnD/9rly7UKhMSh43bMGkzQDXq5bs3BDzXazP0xRI
         KRSNziP6lHPde+j1z2bFBnIAn/UeCWKLMkAfm/OfZC5qzaEF0D5vnhOXAec4qOHNRwTP
         dgDLH7aF2DX//GS6MyqILe6Oz7VtL1Ccq6InkZhBPwmB6GZDaJZq7dVmziFTJV5WJLrn
         zdC4vQrIvjOflI6Jrz84WujL8Jb+qveAHa4KW3wcPQoGZA3kV/CqWRN9lz8rysoSTIFQ
         KB9touJyH7y7pkjG05U3//uh0VvOcw4ujgdlAKKVsXvZqftfDwUAa8zKJJPrg4SjrQAK
         Qcjg==
X-Gm-Message-State: AO0yUKVDEm+0bNm3Cz829nQO9XsNml8VSUiBw025i6qGEUkBNCuLLNKg
	o4P5LV8RhzvUt05WQz7hPabMlmkWQc/nro8F0gYv134NpbJ4uwCfiAhqBuaoQOK1i0CAKxUG9ep
	QrNjVs287Q3o7OYQzFXPqYlmMjNn4
X-Received: by 2002:adf:e30d:0:b0:2ca:f86a:9643 with SMTP id b13-20020adfe30d000000b002caf86a9643mr12775051wrj.0.1678287850783;
        Wed, 08 Mar 2023 07:04:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8THxZbNAypBX0eNX63sSaBP4T22RG0SEQqvTx2BCqHbd7aKjiaM6PPNyeucewaAKYav+3LOg==
X-Received: by 2002:adf:e30d:0:b0:2ca:f86a:9643 with SMTP id b13-20020adfe30d000000b002caf86a9643mr12775028wrj.0.1678287850452;
        Wed, 08 Mar 2023 07:04:10 -0800 (PST)
Date: Wed, 8 Mar 2023 10:04:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Edmondson <david.edmondson@oracle.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230308100357-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <0a784140387c2a592f7e1e7bbc5ae926ec5b45da.1677761896.git.mst@redhat.com>
 <m2leka0yvl.fsf@oracle.com>
 <20230306165907-mutt-send-email-mst@kernel.org>
 <m2r0u0zxkk.fsf@oracle.com>
 <87fsafl452.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87fsafl452.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] [PATCH v10 01/10] virtio: document forward
 compatibility guarantees

On Wed, Mar 08, 2023 at 03:16:41PM +0100, Cornelia Huck wrote:
> On Tue, Mar 07 2023, David Edmondson <david.edmondson@oracle.com> wrote:
> 
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> >
> >> On Mon, Mar 06, 2023 at 01:53:50PM +0000, David Edmondson wrote:
> >>> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >>> 
> >>> > Feature negotiation forms the basis of forward compatibility
> >>> > guarantees of virtio but has never been properly documented.
> >>> > Do it now.
> >>> >
> >>> > Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> >>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>> > ---
> >>> >  content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
> >>> >  1 file changed, 42 insertions(+)
> >>> >
> >>> > diff --git a/content.tex b/content.tex
> >>> > index 0e474dd..0c2d917 100644
> >>> > --- a/content.tex
> >>> > +++ b/content.tex
> >>> > @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
> >>> >  In particular, new fields in the device configuration space are
> >>> >  indicated by offering a new feature bit.
> >>> >  
> >>> > +To keep the feature negotiation mechanism extensible, it is important
> >>> > +that devices \em{do not} offer any feature bits that they would not be
> >>> > +able to handle if the driver accepted them (even though drivers are not
> >>> > +supposed to accept them in the first place even if offered, according to
> >>> > +this version of the specification.) 
> >>> 
> >>> I find this (the bit in parenthesis) confusing.
> >>> 
> >>> Why are drivers not supposed to accept features that they have been
> >>> offered, given that they can't know that the device cannot handle the
> >>> feature that it just offered?
> >>> 
> >>> Is this alluding to the later section:
> >>> 
> >>> > feature bits not described in this specification, reserved feature
> >>> > bits and feature bits reserved or not supported for the specific
> >>> > transport or the specific device type
> >>> 
> >>> ?
> >>
> >> exactly. how would you put this better? given an example?
> >
> > Perhaps it would be enough to say:
> >
> >> (even though drivers are not supposed to accept unrecognised features in
> >> the first place even if offered, according to the specification)
> >
> > "Unrecognised" is intended as a shorthand for the whole "not described,
> > reserved, ...". Maybe "unrecognised or reserved"?
> 
> Hm, what about
> 
> "even though drivers are not supposed to accept any unspecified,
> reserved, or unsupported features even if offered..."
> 
> ?

ok

> I'm not sure how we can make this both short and descriptive enough...



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

