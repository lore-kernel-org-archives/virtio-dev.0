Return-Path: <virtio-dev-return-11974-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF918C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 15:57:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 18D4A2A8E4
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 15:57:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 147B798658E
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 15:57:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 09AD398641D; Tue,  4 Apr 2023 15:57:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA7F798641C;
	Tue,  4 Apr 2023 15:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Tue, 4 Apr 2023 17:55:44 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
        "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        Shahaf Shuler <shahafs@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>,
        Heng Qi <hengqi@linux.alibaba.com>
Message-ID: <20230404175544.0081e48b.pasic@linux.ibm.com>
In-Reply-To: <20230404030629-mutt-send-email-mst@kernel.org>
References: <20230329212341.465843-1-parav@nvidia.com>
	<20230330191114.77acd860.pasic@linux.ibm.com>
	<PH0PR12MB548165C4B11375F8C7EE7AD1DC8E9@PH0PR12MB5481.namprd12.prod.outlook.com>
	<20230404033622.4b749f89.pasic@linux.ibm.com>
	<d62d2090-de0d-0ea6-5c85-ecf19ae828c7@nvidia.com>
	<20230404030629-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0gKYegeuWftmGRZiM8_pucAf4BH2WJ8x
X-Proofpoint-GUID: VylUNoizzkvNLOgqPorYZ6nBjSMuxkPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_07,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxlogscore=981
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040144
Subject: Re: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number

On Tue, 4 Apr 2023 03:07:26 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > 3. Once interrupt moderation series is merged, rename vqn to vq_index.
> > (really vqn reads better even though history say vq index).
> > Because votes is completed and voting period ended for the important
> > feature.  
> 
> interrupt moderation voting is still ongoing, isn't it?

Yes it is. But not for very long. Close date is today. I
won't change my vote because of the index vs number discussion. I believe
we can include that patch in the cleanup if push comes to shove. But
I wouldn't have anything against that ballot getting withdrawn either.
I'm Cc-ing Heng Qi.

Regards,
Halil

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

