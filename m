Return-Path: <virtio-dev-return-12244-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4AEC77B70
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 03:18:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E63EB29FD3
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 03:18:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8B739863D9
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 03:18:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CBDBE9862EE; Mon, 17 Apr 2023 03:18:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B401D986312;
	Mon, 17 Apr 2023 03:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Mon, 17 Apr 2023 05:18:44 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>,
        "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>,
        "sgarzare@redhat.com"
 <sgarzare@redhat.com>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        Shahaf Shuler <shahafs@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230417051844.70ba47cc.pasic@linux.ibm.com>
In-Reply-To: <PH0PR12MB54812C754ED9063E34E06E1BDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
	<20230405010657.612529-4-parav@nvidia.com>
	<20230405012723-mutt-send-email-mst@kernel.org>
	<PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
	<20230405172731.561890b1.pasic@linux.ibm.com>
	<PH0PR12MB54819AFEDBFEC41CACA0CF92DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
	<20230407073308-mutt-send-email-mst@kernel.org>
	<87ile2kdav.fsf@redhat.com>
	<PH0PR12MB54812C754ED9063E34E06E1BDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xcrpC78K93crvHqX434FGnLDNgAwYTBi
X-Proofpoint-GUID: bOcjjXN6PE_3zt3eVCOlIlZZnOPL0wp9
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-16_16,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170027
Subject: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] RE: [PATCH v12 03/10]
 content: Rename confusing queue_notify_data and vqn names

On Tue, 11 Apr 2023 13:35:09 +0000
Parav Pandit <parav@nvidia.com> wrote:

> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Tuesday, April 11, 2023 4:56 AM  
> 
> > 
> > Yes, please leave it as F_CONFIG_DATA, as we're just putting some "data"
> > there in the end (and F_CONFIG_COOKIE might indeed be confusing for the
> > ccw case.)  
> 
> Since Halil didn't respond for 5+ days + Michel and you propose to continue use CONFIG_DATA and this is rare used field, I will rename 
> 

Sorry, this one has fallen through the cracks. For
the preceding ones: I do not have a strong opinion. I do
share Michael's and Connie's assessment regarding a possible
clash with CCW.

Let me just note that the feature ain't called, "F_CONFIG_DATA" (i.e.
with full name VIRTIO_F_CONFIG_DATA) but rather "F_NOTIF_CONFIG_DATA"
(i.e. with full name VIRTIO_F_NOTIF_CONFIG_DATA).

> vqn to union of
> 
> vq_index
> vq_config_data

In that sense vq_config_data is not good in my opinion, because
it misses "notif" which is present in both "F_NOTIF_CONFIG_DATA"
and "queue_notify_data".
> 
> Thanks. Will roll v13.
>

I'm about tho have a look how this panned out in v13. I propose
let us continue the discussion there.

Regards,
Halil
 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

