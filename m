Return-Path: <virtio-dev-return-12275-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF464C77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 11:40:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 212406037C
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 11:40:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B7AF986406
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 11:40:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EF436984043; Tue, 18 Apr 2023 11:40:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA5669863E3;
	Tue, 18 Apr 2023 11:40:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Tue, 18 Apr 2023 13:39:58 +0200
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
Message-ID: <20230418133958.13d5b98b.pasic@linux.ibm.com>
In-Reply-To: <PH0PR12MB548148EDDB407D4B1A3E316ADC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230411192341.751841-1-parav@nvidia.com>
	<20230411192341.751841-4-parav@nvidia.com>
	<20230417054149.5d7f62e8.pasic@linux.ibm.com>
	<PH0PR12MB548148EDDB407D4B1A3E316ADC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rw-x9wUopiVFhuUk8EuHD8FKbkrNRcha
X-Proofpoint-ORIG-GUID: y-FI_WzmoKtwe-m-2Sa45vfkuSl7QH2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_07,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180100
Subject: Re: [virtio-dev] [PATCH v13 03/11] content: Rename confusing
 queue_notify_data and vqn names

On Mon, 17 Apr 2023 20:53:32 +0000
Parav Pandit <parav@nvidia.com> wrote:

> > From: Halil Pasic <pasic@linux.ibm.com>
> > Sent: Sunday, April 16, 2023 11:42 PM  
[..]
> >   
> > > @@ -1053,9 +1059,9 @@ \subsubsection{Available Buffer
> > > Notifications}\label{sec:Virtio Transport Option  If  
> > VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:  
> > >  \begin{itemize}
> > >  \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the
> > > driver MUST use the -\field{queue_notify_data} value instead of the virtqueue  
> > index.  
> > > +\field{queue_notify_id} value instead of the virtqueue index.
> > >  \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver
> > > MUST set the -\field{vqn} field to the \field{queue_notify_data} value.
> > > +\field{vq_notify_id} field to the \field{queue_notify_id} value.  
> > 
> > Seems you did not catch these with the s/_id/_config_data/. By doing the
> > replace one would get queue_notify_config_data, vq_notify_config_data and
> > queue_notify_config_data respectively.
> > 
> > But that still does not seem right, and the right answer depends on to what do
> > we rename \field{vqn}.
> >   
> vqn -> vq_notif_config_data in the notification structure.

I think I got what you mean. I intend to double check it
in v14.

> 
> virtio_pci_common_cfg.queue_notify_data -> queue_notify_config_data.
> 

I have no strong opinion about this one.

> Better to rename
> 
> VIRTIO_F_NOTIF_CONFIG_DATA to VIRTIO_F_NOTIFY_CONFIG_DATA.
> Adding "Y" is not going to make it that long. Field names will have some consistency.
> WDYT?

No strong opinion on this either. I agree with Michael that "NOTIF"
likely stands for "notification", but I also see your point: having
"notify" in the field names and "NOTIF" in the feature name isn't great
either.

IMHO VIRTIO_F_NOTIFY_CONFIG_DATA should remain aligned with
VIRTIO_F_NOTIFICATION_DATA in one way or another. Thus way out would be
to do something like:
virtio_pci_common_cfg.queue_notify_data -> queue_notif_config_data

I think as editors Connie and Michael should have the most say in this
though.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

