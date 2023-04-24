Return-Path: <virtio-dev-return-12363-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD60C77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:54:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 172312B068
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:54:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EACA798640F
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:54:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CBB65986350; Mon, 24 Apr 2023 15:54:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B956098635B
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 15:54:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1XOYgPWAMDyJ2X_joEIoWA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682351653; x=1684943653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw0q+yjBrrJ0HHXQJhvUcTYRS5Zt9SKI9OLkAQu5Zfc=;
        b=B3a8cmT8FnvrXvg+qaqvHBwZVcltnt8wTuU0JhXx5VSmaVcQI2mlObd0aellojfW5Y
         /nsdzC1blb1N/EXSCB/arpYDWhYFZgiWnzO3r6E8ZhrHt6vX0+xbC4nPLbrt7eWJapJS
         ahZy2WshCqz16eWM8ZFJUs0DWCoe8b5mSkSx3M5jVoEJ5MLVjHnEnWs5VkmGEZWM4UtM
         WxtNeTzE64Z6ahXUCpJgDqNrvQpzlPoUfEVEGxgLU9ESM+jEc/vdA2IfhowCahcbyk8V
         LheKp4mtbQa19D+KYfuErXv7ZdzfO8be5LMcmQrL2Rb5cFCkNoHWy8N5noNhrRGZSbbu
         eOfg==
X-Gm-Message-State: AAQBX9d3IO/d1TdtctaEdG++ZBh9oQ94qOLfTrpvhIdksyR3EzLL7tOy
	53mN5Y5eLjE5zjq0RkNqPlIzDq7SwVSnpt28YQhJPTHkjwwycnrSDZMjcso342PiE8aqr4T3g88
	r6aQVn8f8bvU9Ba23BJODeBir1YSP
X-Received: by 2002:adf:dd85:0:b0:2f9:a798:602c with SMTP id x5-20020adfdd85000000b002f9a798602cmr10101165wrl.12.1682351653400;
        Mon, 24 Apr 2023 08:54:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350bskjSgFi8JPTAoKyofvBzcwCPeNx+Ds13BoDmatciSF/hz7g4V3JO7oIoxBpkyFahUnzn96A==
X-Received: by 2002:adf:dd85:0:b0:2f9:a798:602c with SMTP id x5-20020adfdd85000000b002f9a798602cmr10101153wrl.12.1682351653069;
        Mon, 24 Apr 2023 08:54:13 -0700 (PDT)
Date: Mon, 24 Apr 2023 11:54:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230424114849-mutt-send-email-mst@kernel.org>
References: <20230419014639.919458-1-parav@nvidia.com>
 <20230419014639.919458-11-parav@nvidia.com>
 <20230424152221.54c44489.pasic@linux.ibm.com>
 <20230424094202-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818907C4A9BF2031664166DC679@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54818907C4A9BF2031664166DC679@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v14 10/11] virtio-net: Describe RSS using rss rq id

On Mon, Apr 24, 2023 at 03:30:33PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 24, 2023 9:59 AM
> 
> > > >  Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command
> > 
> > maybe add:
> > 	including virtqueue index of relevant receive queues
> > 
> Structure struct virtio_net_rss_config has many fields for RSS_CONFIG command.
> It is not much help to say including receive queues, including indirection table etc.
> The structure is evident and all those fields are described in the struct including the receive virtqueue.

ok

> 
> > > >  struct virtio_net_rss_config {
> > > >      le32 hash_types;
> > > >      le16 indirection_table_mask;
> > > > -    le16 unclassified_queue;
> > > > -    le16 indirection_table[indirection_table_length];
> > > > +    struct rss_rq_id unclassified_queue;
> > > > +    struct rss_rq_id indirection_table[indirection_table_length];
> > > >      le16 max_tx_vq;
> > > >      u8 hash_key_length;
> > > >      u8 hash_key_data[hash_key_length]; @@ -1453,10 +1458,15 @@
> > > > \subsubsection{Control Virtqueue}\label{sec:Device Types / Network
> > > > Device / Devi  \field{indirection_table} array.
> > > >  Number of entries in \field{indirection_table} is
> > (\field{indirection_table_mask} + 1).
> > > >
> > > > -Field \field{unclassified_queue} contains the 0-based index of -the
> > > > receive virtqueue to place unclassified packets in. Index 0 corresponds to
> > receiveq1.
> > > > +\field{rss_rq_id} is a receive virtqueue id. \field{vq_index_1_16}
> > > > +consists of bits 1 to 16 of a virtqueue index. For example, a
> > > > +\field{vq_index_1_16} value of 3 corresponds to virtqueue index 6,
> > > > +which maps to receiveq4.
> > > > +
> > > > +Field \field{unclassified_queue} contains the receive virtqueue in
> > > > +which to place unclassified packets.
> > >
> > > It does not contain a receive virtqueue but its \field{rss_rq_id},
> > > i.e. it's "receive virtqueue id".
> > 
> receive virtqueue != virtqueue index.
> The receive virtqueue is description. The structure rss_rq_id is clear enough to indicate that how an receive virtqueue is communicated with the device.

the text originally was pretty clear though, the only problem
was format of index was unclear. your change me and Halil
both feel obscured things.

> > Yes all this last chunk is not an improvement.
> > My whole point was that we do not need a name for this thing that is struct
> > rss_rq_id. It's just a weird way to store a vq index.
> > 
> > Also \field{rss_rq_id} is confusing since it's actually \field{struct rss_rq_id}. We
> > are using C-like not C++ like syntax ;)
> > 
> > One way to address all this:
> > 
> > \field{struct rss_rq_id} contains a virtqueue index: \field{vq_index_1_16}
> > consists of bits 1 to 16 of a virtqueue index. For example, a
> > \field{vq_index_1_16} value of 3 corresponds to virtqueue index 6, which maps
> > to receiveq4.
> > 
> > Field \field{unclassified_queue} contains the virtqueue index of the receive
> > virtqueue to place unclassified packets in, in \field{struct rss_rq_id} format.
> > 
> The data type of the unclassified_queue is struct rss_rq id, so we don't need to emphasis it again.

oh, you can drop that:
	\field{struct rss_rq_id} contains a virtqueue index: \field{vq_index_1_16}
	consists of bits 1 to 16 of a virtqueue index. For example, a
	\field{vq_index_1_16} value of 3 corresponds to virtqueue index 6, which maps
	to receiveq4.
	 
	Field \field{unclassified_queue} contains the virtqueue index of the receive
	virtqueue to place unclassified packets in.

but in any case, there is no point in saying "\field{rss_rq_id} is a
receive virtqueue id." This concept of "receive virtqueue id"
is not really useful.



> For example, we don't say, max_tx_vq is in le16 format.
> 
> I am going to keep the current version as it is better than then extra verbosity.

Maybe "specifies" instead of "contains" then?

+Field \field{unclassified_queue} specifies the receive virtqueue in
+which to place unclassified packets.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

