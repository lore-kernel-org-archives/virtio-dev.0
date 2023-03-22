Return-Path: <virtio-dev-return-11722-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680A2C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 20:57:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6E6292ACAF
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 20:57:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49016986455
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 20:57:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2D84C983EB6; Wed, 22 Mar 2023 20:57:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 108B29864AD
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Mar 2023 20:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qJYQ4bJKMCaycbmAdZETfg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679518618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QAhNC0NtpSVJz+g1CqAQPHjVRSml4FYqUY9oAF+NSA=;
        b=HpoxkyeRiSvk/GjggRkIc4VY8itAwmj+qjZVgroDXzbL/vY/V64BY7F5xROp6OJRAh
         eVj8Co5TIoZuPfslCoBCEiovdl/GE+ISG3KA450U1X5TOoMRtVhWmyEN6fsFsMZnWEyL
         3l+ZrSnyUUc6kK5Mb55FuyOnwExbz/ciFreUsaT/wWreypDdEW3ArbA4cWfiCRvsp2bj
         zimbQY3Y2bn/MomzgjMe272XIl+8W9UHhOKxsxLTaG4SaTotLVKlIhhR41PZsHfaOkii
         jPFxvwsz7YEVQoPLi/Nr5JvWtthnxUKkrjbHnPrpTNK7aMnUXs9qdA3PqBHc+gNN57LR
         3Mdw==
X-Gm-Message-State: AO0yUKUIPpAQDXymBLh8DEf5j9iFENPMOB5bbqFsM01/uyJADwAV/X26
	W1ANL3NacQJsFGZBnBPdMUXzNrc1mssRFSbQF+T8SvKFn1eyol4ksfO3+GEkjD7nf0qQ0W81DqA
	maEwu75NAdjfPm/xMFJ66fmghaGLr
X-Received: by 2002:a17:907:7630:b0:92d:6078:3878 with SMTP id jy16-20020a170907763000b0092d60783878mr3576315ejc.33.1679518617989;
        Wed, 22 Mar 2023 13:56:57 -0700 (PDT)
X-Google-Smtp-Source: AK7set+iM8KrN0eL2x4VjCDzaRUjSn+gYs4hnpehNNGj8renmtURfExhCyOL2MyiZfst25QuZ6PxFA==
X-Received: by 2002:a17:907:7630:b0:92d:6078:3878 with SMTP id jy16-20020a170907763000b0092d60783878mr3576295ejc.33.1679518617585;
        Wed, 22 Mar 2023 13:56:57 -0700 (PDT)
Date: Wed, 22 Mar 2023 16:56:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230322165542-mutt-send-email-mst@kernel.org>
References: <20230321215834.225856-1-parav@nvidia.com>
 <20230321215834.225856-9-parav@nvidia.com>
 <20230321180052-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD9C8A5D0B1B14A3B184DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230321233616-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548118C2FB6C986D945397CCDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548118C2FB6C986D945397CCDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 8/8] virtio-net: Describe RSS using receive queue
 handle

On Wed, Mar 22, 2023 at 05:07:51PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, March 21, 2023 11:46 PM
> > >
> > > > And it's still kind of complex and non-standard. E.g. what does
> > > > \begin{lstlisting}
> > > > le16 rq_handle;
> > > > \end{lstlisting}
> > > > mean exactly? Apparently nothing ...
> > > >
> > > Why nothing, it is referenced further down.
> > > Did you suggest moving before using it?
> > > It was just fine to provide a forward reference.
> > 
> > because it does not say anything about the contents or the format. just some
> > kind of integer.
> > 
> Because it is an integer there is no need of a special format.
> It does say about the content very clearly = vqn / 2;
> But more below.
> 
> > > > I feel what we keep there is really the virtqueue number itself.
> > > > Just stored in this strage format.
> > > >
> > > > And all this talk about handles kind of seems to add yet another term to
> > learn.
> > > > Where in fact all it is, is just a different way to store vqn.
> > > >
> > > > So my idea was this: we say something like:
> > > >
> > > >
> > > > \field{unclassified_queue} contains the virtqueue number of the
> > > > receive queue to place unclassified packets in.
> > > > \field{indirection_table} contains an array of virtqueue numbers of
> > > > receive queues.
> > > >
> > > Above two lines are clearly confusing where virtqueue number describe in
> > rest of the spec and above doesn't align to same notion.
> > 
> > That's true.
> > 
> > > So better to say field A contains the rq_handle and
> > >
> > > struct rq_handle {
> > > 	le16 vqn_16_1: 15;
> > > 	le16 reserved : 1;
> > > };
> > 
> > 
> > 
> > >
> > > > Both \field{unclassified_queue} and \field{indirection_table} use
> > > > the following format for the virtqueue numbers:
> > > > \begin{lstlisting}
> > > > struct rss_virtqueue_number {
> > > It is really not any superior in term of cost of learning.
> > >
> > > > 	le16 vqn_16_1 : 15; /* Bits 16 to 1 of the virtqueue number */
> > > > 	le16 reserved : 1; /* Set to 0 */
> > > I like the structure and reserved bit that enables to claim one bit for some
> > unknown future use.
> > > > }
> > > > \end{lstlisting}
> > > > for example, a value of 3 corresponds to virtqueue number 6 and maps
> > > > to receiveq4.
> > > >
> > > >
> > > >
> > > > and then everywhere else we just say it keeps a vq number, we
> > > > already explained it is using this format once no need to repeat that.
> > > >
> > > I just prefer to rename it to rq_handle ( or at least other than virtqueue
> > number) to distinguish it from rest of the virtqueue number.
> > 
> > Well first of all I really want to make it clear it's specific to RSS at least for now.
> > So let's prefix with rss_.
> Yes, rss_ prefix is good.
> 
> > Maybe I'm wrong but I feel using up a completely new term for something very
> > specific to RSS is a waste.
> > We won't be able to use handle for something else without confusion.
> > So how about just
> > 
> > 	struct rss_rq {
> > 		le16 vqn_16_1 : 15; /* Bits 16 to 1 of the virtqueue number */
> > 		le16 reserved : 1; /* Set to 0 */
> > 	};
> Rq is usually an object and here we want to just refer to its id/vqn/handle.
> 
> Hence, I prefer rss_rq_handle {} or rss_rq_id{} for the structure name.
> WDYT?

_id is ok. But don't define it separately as a special object, it's just
the format of indirection_table and unclassified_queue.
IOW define at point of 1st use.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

