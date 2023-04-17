Return-Path: <virtio-dev-return-12259-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40957C77B76
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 16:13:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 810BE44369
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 16:13:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B1789863D9
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 16:13:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5C7EB98634A; Mon, 17 Apr 2023 16:13:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4879B986353;
	Mon, 17 Apr 2023 16:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Mon, 17 Apr 2023 18:13:04 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Cornelia Huck <cohuck@redhat.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        Shahaf Shuler <shahafs@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230417181304.147838e3.pasic@linux.ibm.com>
In-Reply-To: <20230417024402-mutt-send-email-mst@kernel.org>
References: <20230405010657.612529-1-parav@nvidia.com>
	<20230405010657.612529-4-parav@nvidia.com>
	<20230405012723-mutt-send-email-mst@kernel.org>
	<PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
	<20230405172731.561890b1.pasic@linux.ibm.com>
	<PH0PR12MB54819AFEDBFEC41CACA0CF92DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
	<20230407073308-mutt-send-email-mst@kernel.org>
	<87ile2kdav.fsf@redhat.com>
	<PH0PR12MB54812C754ED9063E34E06E1BDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
	<20230417051844.70ba47cc.pasic@linux.ibm.com>
	<20230417024402-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hoC3ghuKAVizmyNEm9gPXr6kKI_VV9Mw
X-Proofpoint-GUID: jvVd0TXpn9PfOqEHubwCZ7BWLOmXq4B7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_10,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170145
Subject: Re: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] RE: [PATCH
 v12 03/10] content: Rename confusing queue_notify_data and vqn names

On Mon, 17 Apr 2023 03:04:34 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 17, 2023 at 05:18:44AM +0200, Halil Pasic wrote:
> > On Tue, 11 Apr 2023 13:35:09 +0000
> > Parav Pandit <parav@nvidia.com> wrote:
> >   
> > > > From: Cornelia Huck <cohuck@redhat.com>
> > > > Sent: Tuesday, April 11, 2023 4:56 AM    
> > >   
> > > > 
> > > > Yes, please leave it as F_CONFIG_DATA, as we're just putting some "data"
> > > > there in the end (and F_CONFIG_COOKIE might indeed be confusing for the
> > > > ccw case.)    
> > > 
> > > Since Halil didn't respond for 5+ days + Michel and you propose to continue use CONFIG_DATA and this is rare used field, I will rename 
> > >   
> > 
> > Sorry, this one has fallen through the cracks.  
> 
> Well this whole patchset is just a cleanup so it's not holding up other
> work at least. But I have to say it's difficult to make progress when
> someone comes back from outer space after more than a week of silence
> while others finished a discussion and reopens it with some new
> feedback.

Sorry, this was after 6 days. I didn't know that qualifies
as 'outer space'. As pointed out below, I was monitoring the preceding
discussion, and since the way things went was and is acceptable for
me, I didn't want to muddy the waters any further.

The issue I ended up addressing got introduced in very last email, which
pre-announced the next version.

My first intention was to explain myself, and apologize, after being
called out.

But then, also looking by looking at v13 I realized that
there might have been a slip up because F_NOTIF_CONFIG_DATA got shortened to
F_CONFIG_DATA in the discussion, which is no big deal for the discussion
itself, but may have leaked in the v13 proposal. Parav has sent out the
announced next version after about 8 hours. And if it weren't for my
hypothesis why we ended up with the proposed name vq_config_data, the
right place to discuss further would have been v13.

In hindsight, I see, replying to the v12 thread wasn't a good move.

[..]

> 
> I also feel high latency is one of the reasons people are beginning to
> ask to split into subcommitees where they won't have to deal with this
> kind of thing. 
> 

I tend to agree. 

> Let's try to keep the latency low, please.

Believe me, it is not like I'm actively trying to introduce extra
latency.

Regards,
Halil

> > For
> > the preceding ones: I do not have a strong opinion. I do
> > share Michael's and Connie's assessment regarding a possible
> > clash with CCW.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

