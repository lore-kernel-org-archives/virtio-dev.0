Return-Path: <virtio-dev-return-12027-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852E0C7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 14:58:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E53A23DF2C
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 14:58:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF5D79865C1
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 14:58:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D527C986423; Wed,  5 Apr 2023 14:58:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C266F9865A8;
	Wed,  5 Apr 2023 14:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Wed, 5 Apr 2023 16:54:44 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Heng Qi <hengqi@linux.alibaba.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        David Edmondson
 <david.edmondson@oracle.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230405165444.1f483339.pasic@linux.ibm.com>
In-Reply-To: <20230405050718-mutt-send-email-mst@kernel.org>
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
	<20230404182925.349d402e.pasic@linux.ibm.com>
	<PH0PR12MB5481969DB61A7CB30E89C3C4DC939@PH0PR12MB5481.namprd12.prod.outlook.com>
	<20230404134141-mutt-send-email-mst@kernel.org>
	<c2239805-3f62-ee76-d422-2f6c247b7747@nvidia.com>
	<20230404161213-mutt-send-email-mst@kernel.org>
	<PH0PR12MB5481D95889A86A9BF9889C5CDC939@PH0PR12MB5481.namprd12.prod.outlook.com>
	<20230405050718-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0_Th0IYRbJ6tigm6wUvYlzj1u2h15Jji
X-Proofpoint-ORIG-GUID: RSXx4a0YZY3a12aWXgSKbGsVU1vRbqy4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050132
Subject: Re: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation

On Wed, 5 Apr 2023 05:12:12 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > > it's not necessarily an identifier. can be e.g. just 0 for all vqs.
> > > whatever the device needs.  
> > For driver its just an id, content doesn't matter.  
> 
> No, this value might or might not be somehow related to the vq but it
> does not have to identify it. So it's some data, not an id.  Let's try
> to use words for what they mean in english not try to come up with our
> own language.

I agree with Michael wholeheartedly, we should try to use words for what
they mean in English, especially in Computer Science English, and even
try to pick the most fitting and least ambiguous option if multiple
options are possible.

In that spirit I would say that "queue_notify_data" is actually a magic
cookie. https://en.wikipedia.org/wiki/Magic_cookie A possible name
or abbreviation would be vqn_cookie like "a virtqueue
notification cookie" (I'm not sure about mixing in the direction, but
this is only about driver -> device notifications). 


And then 

le32 {
        vqn : 16;
        next_off : 15;
        next_wrap : 1;
};

could become something like

struct vq_notif_data {
        union {
		le16 vqn_cookie;
		le16 vq_index;
	};
        le16 {
		next_off : 15;
        	next_wrap : 1;
	};
};

BTW since "identifier" and "unique identifier" are not the same, in my
opinion "identifier" is still viable, if we explain that it is called
identifier because the idea behind that field is to be used to identify
the queue, but that there is in fact no requirement on selectivity let
alone uniqueness.


Regards,
Halil 

 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

