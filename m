Return-Path: <virtio-dev-return-12531-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F42C7EE22
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 21:45:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D06393DF2D
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 21:45:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3C999866B7
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 21:45:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B882A9866A4; Wed,  3 May 2023 21:45:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A58A998663F;
	Wed,  3 May 2023 21:45:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il1As/S8TCU1gcGAwUxdsA6w5DA3fZIGoYI5eYxuK0wJpCHkxS20sSQITjOGlKnKcS1dgc0x9Jeb8StsdalVon6oY5o4t+W2Pk3T/lQwM9ZKzwVhi6cPutkazM+aHnsZkudWSI3EXfHFOOfsFdWTihKQhwbM62HZHCSAoT9AoMxp8tCVdqIzNIcS9PkQU4EgT3AjUQqYFxcH5nbIvGRACUYZ6aUKHLn11AzGDrBHW4Cj3y5sZ42HTvsFEI7O5rQ6UqZfkAg2MCGn2mTg4lXfWLJRLFAnv6Qf0nQ8H6SzvUCpse6VM0cY5/yxlVsjMEXmaVSgoecnvTDnpgbYTHuhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbX6pe7MMBbroXzFbXp9C6mH8+0oHB03d1SA2VVRyhg=;
 b=nyQIzPWCjV4HEsIR64QH6UyBXO2VQv6QeEH/mIuGfe/CxN7eoC7rAa7BxHyxkAl6ngyIc8ngHwzSywmhU+zCO7xuUOhsCZfZgLw1NL9ActOBHKAQATGVzKJIFG4yhDNVNP2SRYDBHdixxrk5vaNeMptJ78CsxX1xuZ30R3KyVKD3d5kU3UL9Fql77yOTik0KwfEm8x4EAYYDFotvO/7SiaCJRukAP9d4eYNSH+YLlrm6StEf3KUe81hjBPMtCissEqf3p1VFkZXJPXlAN3UUPJynel+QJUBLpY3KFll1n1/fPj3l3Rm0qwr1gY/unzh2EBH7TKV4GEgVw7c2+WeBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>
Cc: "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "pasic@linux.ibm.com"
 <pasic@linux.ibm.com>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        Shahaf Shuler <shahafs@nvidia.com>
In-Reply-To: <PH0PR12MB548187CC08E9DA78AEB3A9E1DC6C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230428041949.411221-1-parav@nvidia.com>
 <20230428041949.411221-2-parav@nvidia.com> <m2lei5vh2z.fsf@oracle.com>
 <PH0PR12MB548187CC08E9DA78AEB3A9E1DC6C9@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Wed, 03 May 2023 22:45:14 +0100
Message-ID: <m2cz3hum1h.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::13) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CY5PR10MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab63fd9-3624-4434-ec5e-08db4c1fb09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xkCIFRORj6s3w4ka0CxujF/PDIRIqjqYzH0iCJz2btPFANC5p8jSeo7aG0xgQzrRt/8UNfwdY+Uw2kmFRJcR2BVJyge9rPwN7hubPVIz/mA/PSdq33Amd0+1b607u7WU2T2+QALMMVy0YZQwxsvqQbFxQvXJGu+nuUwSyeWNpl1iVs6wZPilf7DGEdhHizY2EeBxZbwwhufcVtTX+/x/i9moUR5ugOw4EDqN+Ki3dxIPryo9rGVdTI5tN8ldKkHBlpfBJBxp8MpsLVgarllJaH88/BPWG6o0VZqRObN9dhZvGYz5iYyiqLdl8I0CNZCELIcWhqDJZKJWvlp2KEpTJgphmk8kgv2dIxWxWSfx1tLk5nMIPFAOr+HDS99fb5VstURGlkGWhsHwCdfsnyV/ioF2FysoQ5oJxGdj18Cel0lwW/Byff8ZXnfj787eZCzh6uHPkDgBf35+y7Rqn+Jq8Krw85sPoo8XnOxwONHE5oISK2z+MJ78trRuec/uKMA8rUcKrze1HKVvhI3Blcb+6dc6H1BzDA1chYZ25tudlf7i8fgAM+Qn5QHVCAjL1Is2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(41300700001)(86362001)(8676002)(8936002)(44832011)(38100700002)(5660300002)(36756003)(2906002)(110136005)(4744005)(478600001)(2616005)(316002)(54906003)(6666004)(26005)(186003)(6506007)(6512007)(6486002)(66476007)(4326008)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2o55SmZsdD97GYFcV+QOriO3z33HGWYqSelVcsEb8XS7/r03C4TMZ9L4BrGR?=
 =?us-ascii?Q?UOgztgoXfz43o3Cf3ExwV50KVZFpCLcx6N97BTmBbH6SUj9L4umSWkCINkEu?=
 =?us-ascii?Q?XfcDu5rKtiOpN+eBHxWqvwaBqfKvxX/sMNdGyE7qoOMBDrcjnb187NMeAMzV?=
 =?us-ascii?Q?sCBVYXy7+uTqphKu1XIUGhlxZfPbd8jYeyhMPSXFiuno/hZlqMIxxf6tcuXU?=
 =?us-ascii?Q?coEAN+AJ9BkH85ekaMAXCec3n3DEuSpna+KZ2RsYynSAfqT9Nm9A839U3byQ?=
 =?us-ascii?Q?Wd1dc+3aYh9CMgjwnWQBmyh0uE7Zu5/YZDXS3ZtqCGD4NPm3PJmn3Kj2FqHp?=
 =?us-ascii?Q?arVB7C55KYICMQvqEuwdXs/z+8J3BwlNjdWisWiiQ33GSjttt+2ej6B3JEjh?=
 =?us-ascii?Q?8mgqZof4w+PtPI3SRUw5mG9gRh+101eBB+7pun1qYoy1kQoic3bRQ0PX8scS?=
 =?us-ascii?Q?bc49GCrUESMyyqAgvjro4AjovmUPQDvcNWCDyH7wqfWCQekUDsZOWw+GfXSf?=
 =?us-ascii?Q?DA5G8j0wFqeTJtO4i6nfoH8+jS3NPzGipdhMDaduDwwFwMnY7vFNNVaSXwB4?=
 =?us-ascii?Q?SP+DFETiuDT7H1Pfyk4yMZa2fu1191j2nYcNZGYPECbdwBND1JAm2/E4TEAI?=
 =?us-ascii?Q?vNfor9OniQIe2opyksp+Xl8cvvwQEfrAmfNo1XbyV4ozt9ZrZGtABTaLqU9O?=
 =?us-ascii?Q?AiYlhgmiv079TaSKWx80oV+H8o3TZaRTYFhxuQi777561fjTOzI2bHl3NafB?=
 =?us-ascii?Q?3JiFt50LeoCEXldpi+gaTHshA4dU+KJ6MLLPYAISp1aEzt0/m1a6MsIUWfLr?=
 =?us-ascii?Q?dIRaoTdImq7QOKE15rL0iURPvC7KlhBfr+JOBUY1Vsp7AuIyHM5u+olvO/VM?=
 =?us-ascii?Q?FkmAfpypwBSUPPmq4U1ZYkK3n7VnRUEkpIXVJQZSwWDRYlTUXFfRiyVTtQ9S?=
 =?us-ascii?Q?xUiqmWzDlL1Bwv3W9Q/nRw9Ylrlb9ihNQ0PTYo4ELTMBKz/c5zl66+sK4s24?=
 =?us-ascii?Q?k+vJ/t+OOWxhkWw3YHXLB0RPGIux8FK6Mf1VNScyjlZ6ufETS8E1mYAWU8iy?=
 =?us-ascii?Q?LnPBtrySm5NATaaPcGTrK5+N+CWYWqi8Iyc6pAm7blKTjrDVR3wr9HJ9jrpx?=
 =?us-ascii?Q?nKZ+bqw2NJVDpqUzYtn9KCe6SnmqhjRR/XmpYlW99isg3t8Umy9ycBZsV5BF?=
 =?us-ascii?Q?n0QiskzIKFoxeHrgTpgf/L/5LgxjZVh/hpLEgFgUus6+w86LTEPNy/Cb3fRV?=
 =?us-ascii?Q?kCepET/dympBJOqnfwqqUl8B/fAGEsA1fa8MLhMaunYawnGjDKb1qc15vEGr?=
 =?us-ascii?Q?7nQiHwOKGdQaBsT6145JpqrOpvPLFYfqJKU0Z7vBZQzBDDqKzGDQ/dJSNALG?=
 =?us-ascii?Q?DVDeuSepof6wWKg8OXXIg+Mft5PtGumkUpdyN5H3l35Ni7CR7+auW112lWkm?=
 =?us-ascii?Q?vAFKkL5esZnuBKlf/xGrbXWabeCv5MlvR6g8T2tu0atrPmVmQZ1jiGhCNi09?=
 =?us-ascii?Q?QCd+QXLDLqLZf/9aDkFmyEgUBCAeu18J4BNDAVQmPB7QqXAUFBZP8RYZ0BvG?=
 =?us-ascii?Q?OeX8a8QL0+IGQLyg2U3ja8Z99bb3SxC/5ikIcUtviSj6OooabvHoQO3QsHzH?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3YJl4/UYP67Qmpwb6PiY8wgX2O34BKrB6MOQV+i9xgNp8VAz2IIuCp6gzE7ID6F1OHiOHVI+bFet3TwVT+dwbugHtwOJc5dNBz9sY/f/zMTmqBkTzzjW2fuGj7ZlJHI8MR6v7n6RJL71dO6wnfMRX0f7CNGYGlMFsw55b/neoVEe2uZ5g61mp1W0UkIRaUwQF5kNayM9pHkB6rZ3sg3QHV+0jmskI+xV7EADtoA6rrOJMtG4KAsyA47w5RfbJ8ZFN6z9PEmFi+1pVvM0SXOogYZ+/Bbn2T+9E1JGOEDaTiL/jf3MoiR60piCaX2oYQ8osrAUvl4vJyRA+NSBgtqp8zML1ghRkZE/gb5GrcdxHGhL6RgifDrbjKJuDxXCXZPPfhRdQpTFsmONTT8r68gxF63a7Tj1qbcUAlTJp9PqV/uVi606CI+T/FUv/FDlZ97p0KmO2xWIljtbZU3Dvvpz6DMmurNLwu4WAb/xFj+Bw9/27SfIKR8ZymbQj4uWrABIRboV9R+xMIRkfsxYVgkPwhjGxRIXQwvjg5IkerwBWRKrdN8idJ0yWWRaJlLghWlrIU+sOeqzNCKVNiejeIh4Xowv1ON5SkVxOYBUK0lnlpQ1nPXBtkD7goguij+ShN/wmWepLucSuzIYNKTg+8/K+8dYx7uDpv3ZdMrtwCQaR/oCVpeUEllhwASN6YfRuKn/mNVjSy4FJ2mZyQEkVQZ2IcoDvtvnvzN3W+DeD/mrqJgPLknEc+4dmhPNZmixAuGl5VJveOUTDWYezjikg8Wb4WV28I0SXnrO4nP9joFv9HoBuMExWQf/wijCp85rfFaF/SL6FyzAkVBLEjkjZ8yXEPNFwztqh98Zp4Ov5U9UFnmIP/3tSLj5sbKC4lGJtO/k
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab63fd9-3624-4434-ec5e-08db4c1fb09b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 21:45:19.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZyMB1DUKyBxGlVzHtqmDYFOM+fJdKGDdeccQaT36fl7tnB7IeX4zwaW5OauZMqx6ilbQZMzMs3t68vtZVYkJrFFu6wNvPdXjIy+GbRx0/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030186
X-Proofpoint-ORIG-GUID: Hx_Z4maAMw1Vb8-JQQ9iXEmmVpzMb8nF
X-Proofpoint-GUID: Hx_Z4maAMw1Vb8-JQQ9iXEmmVpzMb8nF
Subject: RE: [virtio-dev] [PATCH v15 01/11] content: Add vq index text

Parav Pandit <parav@nvidia.com> writes:

>> From: David Edmondson <david.edmondson@oracle.com>
>> Sent: Wednesday, May 3, 2023 6:35 AM
>
>> >
>> > +Each virtqueue is identified by a virtqueue index; virtqueue index
>> > +range is from 0 to 65535 inclusive.
>> > +
>> 
>> The range is a property of the index, so generally we would say "a virtqueue
>> index's range", but that feels a bit odd.
>> 
> The range applies to the virtqueue too. Index is only to identify it.
>
> So how about below,
> A device can have maximum of 65536 virtqueues. Each virtqueue is identified by a virtqueue index.
> A virtqueue index can have a value in range of 0 to 65535.

Seems good.
-- 
When you were the brightest star, who were the shadows?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

