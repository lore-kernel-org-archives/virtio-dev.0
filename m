Return-Path: <virtio-dev-return-11949-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AEBC76196
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 01:37:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4EAC82ACA1
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 01:37:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4081898640C
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 01:37:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 351BE9863E6; Tue,  4 Apr 2023 01:37:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F10A9863E4;
	Tue,  4 Apr 2023 01:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Tue, 4 Apr 2023 03:36:22 +0200
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
Message-ID: <20230404033622.4b749f89.pasic@linux.ibm.com>
In-Reply-To: <PH0PR12MB548165C4B11375F8C7EE7AD1DC8E9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230330191114.77acd860.pasic@linux.ibm.com>
 <PH0PR12MB548165C4B11375F8C7EE7AD1DC8E9@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FcZb8tQ7ANmbXo2b9TTW-Cm9UY0P6aYW
X-Proofpoint-GUID: 9AGKenheMpkKufouaczy-9rU7rd6He3F
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040012
Subject: Re: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number

On Thu, 30 Mar 2023 19:13:47 +0000
Parav Pandit <parav@nvidia.com> wrote:

> > From: Halil Pasic <pasic@linux.ibm.com>
> > Sent: Thursday, March 30, 2023 1:11 PM  
> 
> > Currently virtqueue number is only used in the parts that describe
> > notifications (Guest->Host), the rest of the spec uses virtqueue index.
> >
> > I argue that using a different term in that context than in the rest of the
> > specification makes sense, because in the context of notifications the virtqueue
> > isn't always identified by its index.  
> Using single term as number is possible, so lets use single term. 
> 

I don't understand. In my opinion we should use a single term for
a particular thing, but we should avoid using the same term for
two different things.

One thing is the zero based index of the virtqueue, for that
unfortunately we currently have multiple terms: virtqueue index
and virtqueue nubmer. To remove ourselves from the index vs number
discussion let us call it "X".

Another thing is the what you below propose to call vq_identifier, but
for the same reason as above let us briefly call it Y. "Y" may hold
an "X" or a "vq_notification_data" to use your term -- we both agree
on that so, I believe we should both agree that "X" and "Y" are distinct
things an need distinct and easy to distinguish names.

What we currently have is:
* when we mean "Y" we write "virtqueue number" or "vqn", 
* and when we mean "X" we write either "virtqueue index" or "virtqueue
  number"

Now let me pull the historic argument for consolidation on "virtqueue
index" rather than "virtqueue number".

Most of the occurrences of "virtqueue number" were introduced by
commit 4ca1311 ("VIRTIO_F_NOTIFICATION_DATA: extra data to devices"
and commit 2ff0d5c ("virtio-net: Add support for the flexible driver
notification structure.")

And I argue most of them stand where we mean "Y". Some of them
don't and that is bad.

Please have a look at the v1.0 version of the specification:
http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-370007
and search for "queue number" and "queue index". For "queue number"
you should get 1 hit and for "queue index" 8. All of them mean "X",
because "Y" was introduced later.

I argue, it is more sane to assume that the single "queue number"
occurrence is a back then quite harmless mistake (all we had is "X", so
we didn't have the "queue number" means "Y"), that to say the 8
occurrences of "queue index" are all mistakes.

Your approach to resolving the problem is: 
* change all concurrences of "queue index" (all stand for "X") to
  "queue number" 
* change the occurrences of "queue number" that stand for "Y" (that
  is most of them) to "vq_identifier"
* keep the occurrences of "queue number" that stand for "X" as is

Yes that way we can reach an in itself consistent state.

I argue that the following approach is better:
* keep all occurrences of "queue index" as is (all stand for "X")
* change he occurrences of "queue number" that stand for "X"
  to "virtqueue index"
* if we can find a name for "Y" better than "queue number"
  replace all remaining occurrences of "queue number" with
  that new name (I agree "queue number" is not a very good
  name for "Y")

Both solutions are equally consistent in themselves, but I
argue the latter is better because:
* it is more consistent with historic usage
* in my subjective opinion "queue index" is a better
name for "X" compared to "queue number"
* it requires fewer changes.

@Michael: Do you agree? Disagree?

Parav, your work is very much appreciated. I know, the messy
current state is not your fault at all. In fact it is to a certain
degree my fault. 

> > 
> > More precisely: if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated in the
> > context of notifications the virtqueue is identified by the so called
> > "queue_notify_data"; 
> > if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated in  
> 
> You missed "not" before negotiation. :)

Right.

Regard,
Halil

> 
> > the context of notifications the virtqueue is identified by the virtqueue index (as
> > usual, for example in queue_select, or in the ccws).
> > 
> > As I've pointed out in my comment to patch 2, I believe replacing virtqueue
> > index with virtqueue number is detrimental to clarity.

[..]

> > @@ -413,7 +416,9 @@ \section{Driver Notifications} \label{sec:Basic Facilities
> > of a Virtio Device /  the following information:
> > 
> >  \begin{description}
> > -\item [vqn] VQ number to be notified.
> > +\item [vqn] Identifies the virtqueueue to be notified. If
> > VIRTIO_F_NOTIF_CONFIG_DATA has been
> > +      negotiateted, the value of \field{vqn} is the notify data suplied by the
> > device  
> There is still vqn here.  So no better than vq number.
> To be truly clear, it should be renamed to vq_identifier, that either contains vqn or vq_notification_data.
> 
> As I replied I can take up that cleanup at later point if we find some motivation for CONFIG_DATA use.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

