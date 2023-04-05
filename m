Return-Path: <virtio-dev-return-12028-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80433C761A6
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 15:30:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D33B029FD2
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 15:30:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C45879865C9
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 15:30:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B375E986423; Wed,  5 Apr 2023 15:30:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94FC09865A8;
	Wed,  5 Apr 2023 15:30:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Wed, 5 Apr 2023 17:27:31 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        Shahaf Shuler <shahafs@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230405172731.561890b1.pasic@linux.ibm.com>
In-Reply-To: <PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
	<20230405010657.612529-4-parav@nvidia.com>
	<20230405012723-mutt-send-email-mst@kernel.org>
	<PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JoTacAJFL7KvesXRychC9rxg1Wc2tkFS
X-Proofpoint-GUID: PagjqN6q_MGU5chr1og-MO_6mWzYZB2-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050136
Subject: Re: [virtio-dev] RE: [PATCH v12 03/10] content: Rename confusing
 queue_notify_data and vqn names

On Wed, 5 Apr 2023 13:21:40 +0000
Parav Pandit <parav@nvidia.com> wrote:

> > VIRTIO_F_NOTIF_CONFIG_DATA is such a narrow usecase, I don't like burning
> > "vq identifier" on this. How about we just say something along the lines of:
> >   
> Ok. 
> > 
> > When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, this
> > notification involves sending either the virtqueue index or the virtqueue config
> > data to the device (method depending on the transport).
> > 
> > And then "the data sent is a device supplied virtqueue config data".
> >   
> Sounds fine. I will reword it.

FYI in an other thread I proposed calling this a "cookie". Sorry for
being late to the party. Yet again.

Regards,
Halil

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

