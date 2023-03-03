Return-Path: <virtio-dev-return-11423-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE83C64EC4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 15:38:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E6D733099
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 15:38:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 471D59867B1
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 15:38:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2F8229867A1; Fri,  3 Mar 2023 15:38:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A4149867A2;
	Fri,  3 Mar 2023 15:38:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Fri, 3 Mar 2023 16:38:02 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        Shahaf Shuler <shahafs@nvidia.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>,
        Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230303163802.588dfbb0.pasic@linux.ibm.com>
In-Reply-To: <PH0PR12MB54810632DAE7C0D8BEABC9E9DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230223054624.168042-1-parav@nvidia.com>
	<20230227123751-mutt-send-email-mst@kernel.org>
	<20230302165216.1293d066.pasic@linux.ibm.com>
	<PH0PR12MB54810632DAE7C0D8BEABC9E9DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zuVKCTfQlsu---oxGFz5n81T3IONfT80
X-Proofpoint-ORIG-GUID: 2I7JqAcVq2otaXzay9Knqgt2Aterbkya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=957 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030133
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number

On Thu, 2 Mar 2023 16:12:48 +0000
Parav Pandit <parav@nvidia.com> wrote:

> > >
> > > is the index same as vq number? or something different?  
> > 
> > It is something different. The full paragraph sound like this
> > 
> > """
> > Field \field{unclassified_queue} contains the 0-based index of the receive
> > virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
> > """  
> With vqn it can be as simply written as.
> Field \field{unclassified_queue} contains the receive virtqueue number to use for unclassified incoming packets.
> 
> Similarly rss description can be simplified.

But that would change the semantics of the interface (and the ABI). And
we really should refrain from that.

We could also say 

Field \field{unclassified_queue} contains the 0-based index of the receive
virtqueue to place unclassified packets in. Index N corresponds to receiveqN
and thus to virtqueue index 2N.

Provided that we decide to change the naming of the receive queues so
that receiveqN becomes receiveqN-1, and provided that we go with the
virtqueue index and not with the virtqueue number wording.

We could also just drop the name and just say that it corresponds to the
virtqueue index 2N like Michael has pointed out. But I would prefer the
former.

Regards,
Halil

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

