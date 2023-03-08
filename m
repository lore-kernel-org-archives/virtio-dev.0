Return-Path: <virtio-dev-return-11533-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FEBC64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:54:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7568E2AEDF
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:54:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 507DA9866F8
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:54:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 379699866F0; Wed,  8 Mar 2023 14:54:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2246F9866EF
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 14:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: zgVWiJrHNcqjZ4APNjloYA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678287256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahoCudNWzKmcthPDXVKHaHg+T8PQwPPXkEUc9eFbxWw=;
        b=yjFfC1ZPlFiF+GbQ9SB1+uoOy6ZssWzLXlYGLTMBGl3OAuVhyjZGjrnyJQpTrTTnOH
         Y7C2OIkQ3VNjA5YujIkf3xBT4DqBtB1YAu/Ed/JaBnSEyg7o4iGVSb20w4KBUM7PZLdJ
         YluYZng0+bI8YBXj92b9VRGBr2airzzH5BKFPlEPPZ0J4bEWePwn1Zr053fiTUs3o1WK
         tFkEQYQDeGK+DKeoALlglqyI8XsPscFKWQ7FuGDv9OElSgelpuruXXCe4Poa58nz7I9R
         IRiBQVVEAL/qzZNMSSfvUj6DJex1K80/g19Uem88f4ixREfAUSKara38ZPK00VRKmPg0
         wKOg==
X-Gm-Message-State: AO0yUKWzlH2JD8UinYBFx6Owm6iMrCpTABAn1steJSYL8npBdVXQ19wN
	VSoheexwVrf3NBCx1/AyVQmvdQwM0mtD7CsvFHDQBU+XQuiIkLzYbIk2vluWnrOww3sswHz4W/d
	BTXs4eM+WqeDWOpee0eaL4F+CORZ3
X-Received: by 2002:a05:6402:88b:b0:4ad:5220:79f6 with SMTP id e11-20020a056402088b00b004ad522079f6mr17116116edy.18.1678287256158;
        Wed, 08 Mar 2023 06:54:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/CLIA92WXMqiSoBP5S1JZ+npSejcf/I4KlUg3MHBAlUY+Li95k17fESxkJOoiZPZdJIM0Qow==
X-Received: by 2002:a05:6402:88b:b0:4ad:5220:79f6 with SMTP id e11-20020a056402088b00b004ad522079f6mr17116092edy.18.1678287255853;
        Wed, 08 Mar 2023 06:54:15 -0800 (PST)
Date: Wed, 8 Mar 2023 09:54:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230308094912-mutt-send-email-mst@kernel.org>
References: <20230302201912.GC2554028@fedora>
 <20230302185803-mutt-send-email-mst@kernel.org>
 <20230303131703.GB2866370@fedora>
 <20230303081900-mutt-send-email-mst@kernel.org>
 <4f869944-4ccd-c51e-0f30-dc3ba15ffd52@nvidia.com>
 <20230307192752-mutt-send-email-mst@kernel.org>
 <6668fd7a-3eb3-0447-9cbf-72d308b1336a@nvidia.com>
 <20230308070531-mutt-send-email-mst@kernel.org>
 <992e9a1e-3799-842c-79f3-e66f5c823356@nvidia.com>
 <87cz5jl2wt.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87cz5jl2wt.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

On Wed, Mar 08, 2023 at 03:43:14PM +0100, Cornelia Huck wrote:
> On Wed, Mar 08 2023, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> 
> > On 08/03/2023 14:07, Michael S. Tsirkin wrote:
> >> On Wed, Mar 08, 2023 at 12:55:37PM +0200, Max Gurtovoy wrote:
> >>>>> 5. VIRTIO_ADMIN_STATUS_COMMAND_SPECIFIC_ERR (for more info read the
> >>>>> command_specific_error field).
> >>>>
> >>>> I don't think it's a good idea, we'll have to agree to disagree.
> >>>
> >>> Ok.
> >>> can you explain why isn't this a good idea please ?
> >> 
> >> Pointless complexity for spec, devices and drivers. In the end drivers
> >> don't really do anything with all this detailed info.
> >> 
> >
> > Pointless according to your own opinion. As I mentioned, other 
> > specifications and devices work this way. I didn't invent it.
> >
> > All drivers in SW world ? All drivers in Linux ? or Virtio drivers ?
> 
> FWIW, I've spent enough time translating
> detailed-but-not-really-that-useful error status codes to -EINVAL for
> s390-specific things...
> 
> The only thing that might make sense to transmit to a consumer would be
> the difference between "this thing won't work" and "this thing might
> work if you retry later" (if the consumer is even in a place to retry.)

One place where that extra detail might be helpful is device debugging.
But there an error code out of list is too restrictive anyway, you want
"Turbo Encabulator 42 logarithmic casing failure".  I am still looking
for something that drivers are not likely to abuse. Maybe an ASCII
string?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

