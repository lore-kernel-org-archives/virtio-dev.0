Return-Path: <virtio-dev-return-12412-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFBCC77B73
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 16:20:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0FA922CAF3
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 16:20:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02608986471
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 16:20:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EA15D98644E; Tue, 25 Apr 2023 16:20:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1D8E98644B;
	Tue, 25 Apr 2023 16:20:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Tue, 25 Apr 2023 18:20:08 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
        "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        Shahaf Shuler <shahafs@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230425182008.707b3b56.pasic@linux.ibm.com>
In-Reply-To: <20230425091058-mutt-send-email-mst@kernel.org>
References: <20230419014639.919458-1-parav@nvidia.com>
	<20230419014639.919458-5-parav@nvidia.com>
	<20230424152919.70254ffa.pasic@linux.ibm.com>
	<PH0PR12MB5481ABEFADC3ECFD93E645FADC649@PH0PR12MB5481.namprd12.prod.outlook.com>
	<20230425150215.1c445755.pasic@linux.ibm.com>
	<20230425091058-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QZ8aYiaUxbASmDg8wwKkEBOMMdQC2qVS
X-Proofpoint-GUID: 7T2be5vsMrwXGkeliV32eDdgnMLNZ6SF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_07,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250144
Subject: Re: [virtio-dev] RE: [virtio-comment] [PATCH v14 04/11]
 transport-pci: Avoid first vq index reference

On Tue, 25 Apr 2023 09:15:14 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Apr 25, 2023 at 03:02:15PM +0200, Halil Pasic wrote:
> > On Tue, 25 Apr 2023 04:10:00 +0000
> > Parav Pandit <parav@nvidia.com> wrote:
[..]
> > > Sure. All you wrote is correct.
> > >   
> > 
> > I'm happy we agree. All I say we may want to rewrite the 
> > 
> > "Each virtqueue is identified by a virtqueue index; virtqueue index
> > range is from 0 to 65535 inclusive."
> > as
> > "Each virtqueue is uniquely identified by a virtqueue index. The number
> > of supported virtqueues is device dependent, but can never exceed 65536.
> > Thus 16 bit is sufficient to represent virtqueue indexes. If the number
> > of virtqueues currently supported by some device is N, each of it is
> > virtqueues is uniquely identified by a single index from the range
> > [0..N-1]."  
> 
> Seems to be repeating same thing over and over.

Nod.

> This redundancy has cost, e.g. more places to change when we
> talk about admin queues.
> Yes it can not be any number 0 to 65535 but this kind of nitpicking
> belongs in conformance statements not in general description.
> 

I tend to agree. I would prefer to have it in some sort of conformance
statement, but I would also prefer to have it in exactly one place (and
not all over the place).

Regards,
Halil

[..]

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

