Return-Path: <virtio-dev-return-11382-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38405C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:59:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8E1D342A68
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:59:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 872C7986682
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:59:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7B182986679; Thu,  2 Mar 2023 15:59:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67C16986676;
	Thu,  2 Mar 2023 15:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Thu, 2 Mar 2023 16:58:54 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>,
        virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230302165854.3e7cdee7.pasic@linux.ibm.com>
In-Reply-To: <87a60vmbub.fsf@redhat.com>
References: <20230223054624.168042-1-parav@nvidia.com>
	<87a60z5wes.fsf@redhat.com>
	<20230301182207.23f995cd.pasic@linux.ibm.com>
	<20230301123044-mutt-send-email-mst@kernel.org>
	<87a60vmbub.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I7R8Nr7VynsxMhe8OPIgeyVwllfPYzEN
X-Proofpoint-ORIG-GUID: s_GWNBIkZ7oDpbFmjCTzlW2Rp1RSgqej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_08,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=971 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020130
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number

On Thu, 02 Mar 2023 16:06:52 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > And then for extra fun, in the RSS section we say "0 based index" where we
> > seem to mean "this number in the queue name, but subtract 1 in your head".
> > Why subtract 1? I guess we wanted these 5 year olds to practice math ...  
> 
> Heh :)
> 
> Yeah, that looks like a mess... I don't think we should use a weird
> substraction scheme. I haven't looked at the RSS stuff much, would it be
> hard to fix it up?

I just did. I wrote a somewhat lengthy email on that. The TL;DR is:
we should probably rename the receive and transmit queues (receiveq1
should become receiveq0 and receiveqN should becaome receiveqN-1 for N >
0).

Regards,
Halil

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

