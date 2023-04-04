Return-Path: <virtio-dev-return-11985-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF6AC761A6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 19:39:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 864CB33592
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 19:39:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7390A986596
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 19:39:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6694C98658B; Tue,  4 Apr 2023 19:39:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5096F986583;
	Tue,  4 Apr 2023 19:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRddtSkj1oI18f+MvYMFqS0Y3XHxvm+IXM/FeJXsdWO00y0AlWMWVVXgfVxzbRHWomG7p6J+t9CQmWUq2M/sAepTlEMvETmv+dhxh2FmSu9XsSE5+a9FjrDz/0itRmrvq60+esUQL+GXjC1U4/8cNYyTV18bRSZD1IgzZugaRrje/m8OQFdloVDPZ+tASYeV24+3HY+mwCpK2LjgLLPvHIgf9+TADz0OQ+WAfx+3CkbwLbQH7nZA4qQHzB/SxdwHO4YwtPpr3gHXBri3rBZ8w5bi7gE3MB9Bbub8u6iSDoy+e9vdkVt2tHRnV4GaXD0HFI0mEJFwrxDH4qMcHDXysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSaOTLIG0qc+xFHa0u2fiy74V4wheW9MU2AEdEHwa8Y=;
 b=hE3Eu8wNkMtj7uwJuYLaIy6KYvSJo5Kj5vm6Rh3tMcsrMsT8iu3dx6r9m8iab1CGzXKzkn8HkGa5dN7S7RcjBYTWF29PM4CMAfK6nHCzee6KTGUniGiBzRvxvABrexiXlZbasiYcmB1KxwlKRJ+ygdtCyFx513NQ7IK7c5LlJ+35X6XX8lsnggIJ1N4wZ768ueGoF0aS0o5VDMxdJc2icq1sBlnpVEUT/rCJUa8fVMaTarEkMYDZ07mUUMUb45x26XhG44TrBd0AB2MQXUL0KT8DwPh6pQXCWRACbjZaeaNEuqpKZ7X8/YPCq12dPvKh/HjJa7MGK29UDPHdHbnkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <c2239805-3f62-ee76-d422-2f6c247b7747@nvidia.com>
Date: Tue, 4 Apr 2023 15:39:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Heng Qi <hengqi@linux.alibaba.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Cornelia Huck <cohuck@redhat.com>, Alvaro Karsz
 <alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
 <20230404182925.349d402e.pasic@linux.ibm.com>
 <PH0PR12MB5481969DB61A7CB30E89C3C4DC939@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230404134141-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230404134141-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:806:120::35) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: a507a17c-2f81-4975-254d-08db35444b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	toBkQX6ZqDxA2TxvfNgYsx5x+QGvqOSWPH/ik0iGcZAQ9ZwK1bVJC/8YhE1aWwerKzlyr+EniC9/e0QzFH2lXPiPD2HPXO6Wo4dFQ7Xv4nkArh/9X2p1pp8eU1D6QC1TtHVslYEHt7PQI/uZao0BbNPYvY/rK/Te/MUXBiRbFcr34pFQhVi2LUyDbQCiQpFtSutdT9V1qqTgqZGCL1ssFZxoCjxszW8PKR1Ge5uujfPMS39X6CUXefBWCk9+63srKEqM5G12Sc+7+/a/3tzUIP1i6S5x0KKWpsLi5NS/9BGMAv0Xbx4ZU4pdzHZNRUyK6bajQaf0eleUbg69szTPaiGlYf7aFAb1wxzAzJ1fitzXu83Mlh+NZmw0dnSXxP2NKk8xTWW92pfXcoBX9EwGc5Ypi93/MfbOlcMhbje0+nerbtYW7SPwgt5co+6RckEzUTxdFPXYol2enwpa4CfOSvDnLG7yRZgmCvvaeDsMloj2HdZmpRHRMVP+4cAWYSNqSJxfu13AsDcYYHf8/RS5V724TURYXolvaEzYQ5yewMepf0gNww+TdkpTTZj/N0lM9ucpWF0c/2rA+L1McGit+6yUvIjv09xHFXn/QaFDM3nHcynKrS7GSRPV3UTNhoSlmeH5agYHNrg9wb5suS1NgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(38100700002)(2616005)(5660300002)(7416002)(186003)(8936002)(2906002)(26005)(6512007)(31686004)(53546011)(54906003)(6506007)(8676002)(41300700001)(6916009)(66476007)(66556008)(86362001)(31696002)(66946007)(316002)(6486002)(478600001)(4326008)(6666004)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVZTQWU4cnMrMWJMN1ZFd2pRN3R5YTBydkgxOUFsQlUzb2NYOW41NUs3ME1Y?=
 =?utf-8?B?bnBNeE02OXNucU8rQ0cwRkRueWdqR0U3RVRZWCtiYlQ2WVFPWlVqT1lHVXEw?=
 =?utf-8?B?M2U1UGpEaDhqKzJhT0c2QzNQUzlzKzRiWDFaZTZYZitPbUNMMGI5WjlTOExR?=
 =?utf-8?B?cFpZNmFmYkhCbkhYSDdpQURtcGZlTFhvN3lIMzFKam5GZFlCZzVML0piSHdN?=
 =?utf-8?B?bVp3RHV6VDhWLzVwWThNc2IxR1BZODQrYTl1WUdpa1RqVXJYQzM3dTQ0dmFj?=
 =?utf-8?B?QW9PNUFkMU9NT3Fabi9lSjlsTDdRMGptbWJxa2RzVlIvT3ZTMHgzQ0hFUWlV?=
 =?utf-8?B?dUNjYWdIb01ZMktYd250eFppanZhcHZ3RE8wYm5nOFI5NTY2WER4YkgvcTY2?=
 =?utf-8?B?dml3SGhhYTJod20zblJMNGNmYjlLamVHVWo1NEVQVlhjRGt6MElBVXVxODRS?=
 =?utf-8?B?WGZscjNseEp6eERlM3BTaTlJcGFWN3RXcnpnQklvZ0lXZS9vODFEUU1QcUVv?=
 =?utf-8?B?OHdodW1xNTdleHdsNHZ1YW9pVEtkWmo1eXNnNGlWWCswSW5ETXF0ZEVnN1Vo?=
 =?utf-8?B?bmdZT2drcUI5UkZQdCtGdWRYdXp1WUcyUmtSY2xRTkpMZmlYMlIwam40OXdB?=
 =?utf-8?B?Yy8vcWt2MWJoQkVTa2R1VUpNekkwODhmK2wvY0lSWnBYem5LVkg2Y3NxdmVQ?=
 =?utf-8?B?bkRJY0RkMFZBR2hBRkhRZWlaR0QvRmFITVk3YVVIQk53VE50RjEzSlJlREJm?=
 =?utf-8?B?c2JZdS8xMFZuV0tKSCtZNlh2Z05iOU5pRjJwN1c3Q3BCaEp5WVpiRUhvcURx?=
 =?utf-8?B?UHk4d2xmMVgrYTNlTUp0MlhlN0FsRHdQS3J2c0ZsQ2R6bFh1cG81akJJZTlF?=
 =?utf-8?B?WmVhbjR1aWZYcmUxMkU4NWdSRWdIcG9GeHdzcysxOVpLNTRVbEFmQWVYQUFv?=
 =?utf-8?B?Z0pqelRzVjgwMFN2TTJpa2JoUXdqNDUwMFRya2VjTkRhMUNMc1lSVmxaZ3Ra?=
 =?utf-8?B?OUdZK204alk2NzlhZU1Fb1gycElteGdxemplRGRkL3NFeE9xaUp6NTBobHJm?=
 =?utf-8?B?NW9pUVVuN1hkMHhrV0krRUFacDJFZllwbjNyckRKbWNEVnF6OUY5SVN1RXZv?=
 =?utf-8?B?eTFYSVFITDVWbXBlSUdUbE5keU9yKzdpaGIvWWdpdERhbkRQNmVFUllSTFlk?=
 =?utf-8?B?L0JCVC9zNHFBMFh0N2RhdVlTNWI4RnhMQUxUOTE2WnNwSVRQWHdyNkNRZjlP?=
 =?utf-8?B?OUhGeDR4V0tWdGY1V3RBUlFsZ1dxcnpaMm1LdUNESU96Rmd3VUxWeCtabHNm?=
 =?utf-8?B?Z1RzV1loc0NFT1F2eUhoemE5SXRxQ01jcjY4Q3BEV0RSaDZHUVRCTnFqQWlx?=
 =?utf-8?B?UVlKTmFRdlU4aCtTWEZDN1I4WG5XbEYyL1dYN1lPaDVYdk1iRC9sdlJQMUp4?=
 =?utf-8?B?US8xaXZhT1pURVpzdUJoVTBBYzhmM3VzUXZSSDFBTDJGTUVONEhQY20wV1JT?=
 =?utf-8?B?Z3VINWdnSDEyZmxPMStqYUZLMytvZ29SSXNacFMxR0l4WWE3emRIU2VyQVdG?=
 =?utf-8?B?VFdpZXJMdTR0MTZSMWs4WStKMDAvSHhtT0htN0pQb1JVRi83SzROSGo2bENm?=
 =?utf-8?B?aitueVJiVVNQZDZmZFg5bUt4WktSYmdncjU3dVJnMW42ZndsT2o4WXpsayt6?=
 =?utf-8?B?Z3pad0JrbFl5SS9GcHlONzhBcnhUa2lCcHZmMExYZndnM3JtN2RSRmw0NDRU?=
 =?utf-8?B?ekdGVk1UbWxGS2E4cGJWL3pITnFvb3NReklaOUJ3bXkzN0cvbWFjcWlWY05F?=
 =?utf-8?B?Q3ZoR2dONUdoOGhOV0VnNDRURXU5VlVZYWdGY3o4NXl3S1MzNHpkcUZSOTRr?=
 =?utf-8?B?RldXUXlaSDA5b3o3YVhDNU14NEhyTXhIOERwOHBDN2w2MnVoeEoxelBsUDhH?=
 =?utf-8?B?Y3J1TTRnNnJCOWdpS0dHUVdkVjRSZ0Rqd0J2RE9RbHMvdDY0VG4zcmJoczJW?=
 =?utf-8?B?T05PRE5JVmJ0ajJ3R3MrRG9YdXhCeWh5Q1NSYkQ0M0dvb0ZUQWFTOWU0dWNV?=
 =?utf-8?B?MHdiM0puS1NJSVFxMTF0dnh4amVUYzJmclBjTVU4Y1h1U2xwbDVZV3NlQkYr?=
 =?utf-8?Q?NJzgFHoHLXN+XFQDV5KZK5xHt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a507a17c-2f81-4975-254d-08db35444b21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 19:39:23.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uP+7WYMp2cv0TBmQ6iZXqNATtcSv/vCHXCxH4CgK9/qTDjTGrMAOo7qpYvh1syIVqv5P281F8RhacNH+InTZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
Subject: Re: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation



On 4/4/2023 1:44 PM, Michael S. Tsirkin wrote:
> On Tue, Apr 04, 2023 at 04:32:07PM +0000, Parav Pandit wrote:
>>
>>> From: Halil Pasic <pasic@linux.ibm.com>
>>> Sent: Tuesday, April 4, 2023 12:29 PM
>>>
>>> On Thu, 23 Mar 2023 23:24:22 +0800
>>> Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>
>>>> +struct virtio_net_ctrl_coal_vq {
>>>> +    le16 vqn;
>>>> +    le16 reserved;
>>>> +    struct virtio_net_ctrl_coal coal; };
>>>> +
>>>>   #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>>>    #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>>>>    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2 #define
>>>> + VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>>>>   \end{lstlisting}
>>>>
>>>>   Coalescing parameters:
>>>>   \begin{itemize}
>>>> +\item \field{vqn}: The virtqueue number of an enabled transmit or receive
>>> virtqueue.
>>>
>>> Just to be on the safe side: VIRTIO_F_NOTIF_CONFIG_DATA has been
>>> negotiated, and queue_select != queue_notify_data, is vqn supposed to contain
>>> queue_notify_data or the number/index that is used for queue_select (I'm
>>> talking about the PCI transport case)?
>> Vqn has zero relation to notification config data feature and featue bit.
>> It is the real vqn enabled via queue_select.
>>
>> Once the vqn is renamed to vq_notify_id, we won't have this confusion anymore.
> 
> vqn here is the index. queue_select is also the index.
> 
Yes to both. No plan to rename them.

> Inside notifications-le.c we have:
> le32 {
>          vqn : 16;
>          next_off : 15;
>          next_wrap : 1;
> };
> 
> vqn here is queue_notify_data.
> 
vqn in above unnamed structure is contain
a. either vq index if CONFIG_DATA is not negotiated
or
b. it contains queue_notifiy_data if CONFIG_DATA is negotiated

Therefore, instead of naming it as vqn, renaming it to vq_notify_id 
crisply describe what it is for.

And not some vqn n stands for notification, but "d" of data is dropped 
somehow.

A notification identifier contains depending on negotiated feature bit.

> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

