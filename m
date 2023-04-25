Return-Path: <virtio-dev-return-12403-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DC3C77B61
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:06:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A8DC02B068
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:06:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 948D7986456
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:06:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8455298643E; Tue, 25 Apr 2023 13:06:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 723EF98643F;
	Tue, 25 Apr 2023 13:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Tue, 25 Apr 2023 15:02:15 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
        "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        Shahaf Shuler <shahafs@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230425150215.1c445755.pasic@linux.ibm.com>
In-Reply-To: <PH0PR12MB5481ABEFADC3ECFD93E645FADC649@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230419014639.919458-1-parav@nvidia.com>
	<20230419014639.919458-5-parav@nvidia.com>
	<20230424152919.70254ffa.pasic@linux.ibm.com>
	<PH0PR12MB5481ABEFADC3ECFD93E645FADC649@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g83ESZqvj8W5vs4Ym3NntjTKLVSNxxri
X-Proofpoint-GUID: g-3apqPWpjhgMnvh_pX4TyeA4w0Xhb-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_05,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250117
Subject: Re: [virtio-dev] RE: [virtio-comment] [PATCH v14 04/11]
 transport-pci: Avoid first vq index reference

On Tue, 25 Apr 2023 04:10:00 +0000
Parav Pandit <parav@nvidia.com> wrote:

> > From: Halil Pasic <pasic@linux.ibm.com>
> > Sent: Monday, April 24, 2023 9:29 AM
[..]
> > 
> > In [1] you state the following: "There is nothing like a zero based index. A VQ
> > can be any u16 _number_ in range of 0 to 65534.
> > Number can also start from zero. So zero based index = zero based number."
> > 
> > I don't really understand what do you mean by this,   
> Like you described the vq index range is device specific and it is already documented in each device type.
> 

Yes, but we don't actually spell it out. In virtio 1.1 "index" or
"virtqueue number" can be found in chapter 5 "Device Types".

Yes each device has a section "5.X.2 Virtqueues", but we don't spell it
out that the numbers 0, 1, 2 are actually virtqueue indexes.

> A driver can choose to enable its "first VQ" located at vq index 2 for a specific device type.
> So, for device the first VQ is vq index 2 instead of 0.

You read "first queue" as the queue that was "enabled" first. I tend to
agree, the queues can be "enabled" in any particular order. But I don't
agree that the queue that was "first enabled" is the what the spec
currently refers to as "first queue".

I don't really agree with your statement. For example, IMHO, it does not
work if the device has just one queue (like block, entropy) or just two
queues.

I'm convinced, for the device the first vq is always the queue with
index 0, if there is such a thing as "first vq for the device". I believe
the specification does not need "first vq for the device" and similar,
because what we actually need is "the queue with virtqueue index N".

> 
> PCI spec wrote "first queue is 0", this was little misleading how driver and device see it.
> 
> So vq index starts from 0 but it need not be the first VQ, that's what I meant by above line and range description.
> 


IMHO we should make sure the spec can not be read in this way. Because
if one was to choose the vq index 5 from the allowed range of [0..65535].
And try to "enable" the vq with index 5 as the first and only queue of
the virtio-blk device, and use it as such: well that would not work out
well.

> > but I'm afraid it is not
> > consistent with my understanding. Can not be any number in range of 0 to
> > 65534.
> > 
> > Rather in general it depends on the device type, and on the device how many
> > queues it support. Let us call this number dev_vq_max. And if dev_vq_max > N  
> > > 0 index is associated with a queue the N-1 index is also associated with a  
> > queue.
> > 
> > Let me also note that the number of queues supported/provided by the device
> > is a matter of the device. For many devices the number of queues is a constant
> > given in the specification. A Network Device tells its driver how may queues it
> > supports via max_virtqueue_pairs, Crypto Device via max_dataqueues, and
> > Console Device via max_dataqueues.
> > The transports PCI also has num_queues which is documented as "The device
> > specifies the maximum number of virtqueues supported here." while CCW and
> > MMIO have no transport specific means to tell the driver about the number of
> > queues supported by the device. In any case, if the number of queues provided
> > by the device is N, each of those queues is uniquely identified by exactly one
> > index from the range [0..N-1]. Furthermore the role a certain queue plays is
> > determined by its index. E.g. for the Console Device virtqueue identified by the
> > index 3 is the "control receiveq".
> >   
> Sure. All you wrote is correct.
> 

I'm happy we agree. All I say we may want to rewrite the 

"Each virtqueue is identified by a virtqueue index; virtqueue index
range is from 0 to 65535 inclusive."
as
"Each virtqueue is uniquely identified by a virtqueue index. The number
of supported virtqueues is device dependent, but can never exceed 65536.
Thus 16 bit is sufficient to represent virtqueue indexes. If the number
of virtqueues currently supported by some device is N, each of it is
virtqueues is uniquely identified by a single index from the range
[0..N-1]."

And it may be ester than doing a separate issue+ballot for it.

Regards,
Halil

> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

