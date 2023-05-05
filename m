Return-Path: <virtio-dev-return-12597-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71873C77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:59:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 920A442578
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:59:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 804749866FF
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:59:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 72C119866E8; Fri,  5 May 2023 16:59:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5EC9D9866C5;
	Fri,  5 May 2023 16:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZxPPb6iy9jEViUNfaAYzHqVtlKaUcMmu8xgrtuCsm2CR9LjxauOiAMNNnRNubAZjhemucOQAHo1TUALVNCFYTwVXr/N5AFTfiGh+BWC/YrhHq4Z5/hF8ChlYb95TIV7PWRTr2NzPmBrQd1Q9wpk+z7NDKvtuKrR7+HuaJIVBXBCw6gKEsKI6aArEu4sg/SzPxtuQGTVglZ7pFGfHoFYn109Tou66RsM9+T54K4Di2PL07l8yLE0dQgQ4s6v6IyyXSnr4TnjTEFQjRaiD/LtTVrJBFNotKs+BXsTDLRiZ5quhzdlspNdb7eiReS9k7N3r6+aNpm2hysFI9t/P6pC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkdYxtaIkuyM1TO/rLLGT12OqfQZZlB0dpHoftIk7HQ=;
 b=iUbOB1Gjqikl9HkMn9YVytELZTpJuVazkr/ajqhFyO3IdHfItp9EMUHmaqQ8fdoIVKQf13/k198x7mGeAfj1dZ9t9/lVyeZA0fp0WY5AUmzXUXf6fZh9h9rGVCQLfzRhYpyQjSFaQSZb5ucoCWBfY7P//bMW/vsFa7W5Y2Ic7jmw9Vmt9eNxVZJtXYi8e2ABEMCVv/2cJfj2moAy0BHFFAGqHKCi4/wBeaPu4Uw4w2Ocw/C80UH/BRKqwCSkEBWbqir+q0dlVUxMKeSYwcxY0PhJMQ+8cPHqHnmTFvnqfMC3ioeXTwAtzgI2lZBhtohu5B1Mlv9GF+X4DzEVFADY/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <786308bf-a17d-6930-47d3-516528ffb7b2@nvidia.com>
Date: Fri, 5 May 2023 12:59:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1683301091.git.mst@redhat.com>
 <b8f17feea5f4921f89d6395d0b078f766a65e4fe.1683301091.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <b8f17feea5f4921f89d6395d0b078f766a65e4fe.1683301091.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:806:120::22) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: ce00d7f7-949b-4e01-1575-08db4d8a1be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GEox3B6BR0U/FEnFRok1cXsyubvkZ++Kcih620sDftNYxVRJDSWORip5oAHGRSov6fbgAv8cbId5wXI1fSAef0uoFcSfEwT8QYdmdC3Jx2GO9AA2onW+ac9AV0I7ngbFgBcAUiOZwQ/DaFNsE6HY42ZJtsCvNJdHo0LZTpMQf8cWJFbHabgoRQ9d3RBL6UXGzR35U3x6do9HSQW35XvssI2pDyFzmqND8C5ztceWkVKiOWyXIQK9GQJpSRXake9I8nWcP6aWjzsyUb167xUP1viDOgUK3M04rHAMOR4tFJ08LzJ60le3FnbmguqIPpNttWaQ/xSt5G7dJrL3AhNuLrm0IBrXb6XT1eRfrfGhLzraP7c6jEDJEbs9cP2QqGO1RjRxayKJLsonDe5nuzXi9mSDJLWEKOMxnGXNxTzKPE+XVycfIZox25u5e8nlIUcdbxrhsjnFFaJJoSxhyEXfjlAWRhAMmkYPVPPitgap2KP1UdGAw9n9Z3JH/1nLkdLALWTXo3C4boJkB1eF1mgvWMMdeO8UEl9iIqYgPZkJOGDx7VIuTXnnEpblv34cI47E8IlJjQUJ9DNXHIhYOiJLag31DsKUePZ9VGL4aU7Lb4eYujIGLSVsLUbEP7Ll68410GThDeWh7KgR3mjFzt/z5nfOjzePkTZGuELv7cVsBVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199021)(31696002)(86362001)(36756003)(478600001)(6666004)(316002)(54906003)(66476007)(4326008)(66556008)(66946007)(6486002)(41300700001)(5660300002)(8676002)(8936002)(7416002)(2906002)(186003)(38100700002)(921005)(2616005)(107886003)(53546011)(6506007)(26005)(83380400001)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVBPcVhRc1V6dk1Icm1BSHJNZWRyS3FJK00rQ0QxUlA3SkI1YW00ZHJSODFP?=
 =?utf-8?B?ODNhQU43SGljY28ycXZ2cmt4TlkrcUlEZEwyenNsWDhML25JeEREQll0dGNM?=
 =?utf-8?B?UFdjOGt0aEpXYXJjRE4yV0ppZlFvVjVyUUJrMjg2c01qM3p4M0U3MEg1UFpJ?=
 =?utf-8?B?T0pseGt6MGlOWnRBd2pUbklCRXFpQkNWRWdIYWNialMzSDRWOHFtREN6OVZh?=
 =?utf-8?B?NW9PdnB3TmRtMm16WjRnR3lyWTFGN1ZsdW1HQVZsU2NtY1gzMzVoa2NnL08v?=
 =?utf-8?B?QTQzZUxhSlh5d2JTOHFDbGU0Qk9wWjZ2cy9lMC9GSTV2cWRSRjlWQjVHSVlV?=
 =?utf-8?B?M0pyUHJxTStZaENQZjAvZllUV3FjUnZTRXdCVGdyMHU0WHFUYjVoZUZVYk1I?=
 =?utf-8?B?K1EzQTA4a0FlRkRhaHozaXl6eExxNGFNOHBGbUdNSENPb1czOVhYMk9uL1lB?=
 =?utf-8?B?U2hkc2tDbENDOWpnWEZjVWpXQnVzTlRsVnhQQkp4bU1naE1wc1VDRER5WHdy?=
 =?utf-8?B?aWNmMXBiVHlkcDZaR0lkTTNxVHVGY1BsbGY2aS9ELzNyYkVqR2tKcXF2bnJ4?=
 =?utf-8?B?eGF6cUVJbjJ6R1VzaVpPMUtzMTZyVXI1VEJPSm50Uklldi84a01qODkzKzRU?=
 =?utf-8?B?UDE3ekZmQTVodzRseGJYNmNTS1FPMDBENEJkZGV6V1hSS3VvYmtlUUl6VmJ6?=
 =?utf-8?B?eVRkYXFnMzEwMkJCM29ZWGFlUnk4amR0QWdFbEQ4Z0VDZkpKQ1NudTBjMTRC?=
 =?utf-8?B?ZkpqZ2lwLzNYRnJtODVqYzlQYVQyTUk5NGNwcjFXbGptc0ZTbThxbzlDZFhi?=
 =?utf-8?B?QzdKa0N0RkJ5WW4rSXZMOENqN1htWW9FZ3NMS3JUblo1eUFtVXcxQjhwYWtl?=
 =?utf-8?B?OTYyNUtoZnNsdWJrNXRkalN0cGd3U05TdGYzUVN6YTBraWdhRThuS2ZxaVZM?=
 =?utf-8?B?TkNqRW5SSU1NOTN6enBqZUVUdVovREpHbmwwTnc0anRzcnVWRzU3VWJTQ25S?=
 =?utf-8?B?S3J3dEhHZkZ2eEFwNjZTYzhkZDdIOFZwYTdhY1h1TTFCM3hDaDIvTGs1T1ht?=
 =?utf-8?B?eGE4azNlTmVXaEhOUkdnUXRXMVZRbWZGK0RTUXZxb09XRGFERWZmT1RHalUw?=
 =?utf-8?B?MTE5N2NyQnRGdHdJbzIvcnM4VGhsczFzYk8vMGh5cmIzOVdhZzBVQy93dEU3?=
 =?utf-8?B?RnRlTFdpVnFIbGpWSVhZTUVEVWRKSDUvbVhlRW43YTJDRDREQ0NVeEI5bTcv?=
 =?utf-8?B?QzhQbEpqZ0htdFFRYVFnQzBWSURkK04xUzI5MnQ3dStpWFJ0SG1hcDZnVHdt?=
 =?utf-8?B?T1JxeTFzOWIrRGZQdTBFdlQ1T0pDMlJGVU5EazRqZytDcVZvakJzVFJXcUh1?=
 =?utf-8?B?MGlYTzBmbFpQa0lsVlhJQXBDaTZPUThSaFdQMlZ4TTFUa05iWW15TnhkUk9l?=
 =?utf-8?B?bGcrUTlNMm42WXF2VzgxZWJyaHhnNTFjTVh0RHFsbXZTZkVseThzOC92bkZt?=
 =?utf-8?B?bkdSSURlS2ErMUtsWnB4MS9PSHNNZWxSTkE0TGVncHhBM3RmRVBXbWhFYTY5?=
 =?utf-8?B?cUVIKzBYa2xsUXhqWHQ0TzNybkkvM3ZXdmQ1THBjT0FDeE9ycGhYWExqdjU4?=
 =?utf-8?B?WHNsRkljOUZ4SVNtSG4zUW51M3JDVWRGU0FrS3Z6aHVrRVdRN0dXSm5yZVZB?=
 =?utf-8?B?QjFiYWlaWmNDalpSNEtmWDdkNzRMZnZwTmdPcHEvejVRSzlRSGVyTkhCcnhv?=
 =?utf-8?B?NC9GeHQ5TmRIQ0F0NGFqNHprVGlIQXpsUzNWNi9NREdmdXY5cUFSK2NpYk5x?=
 =?utf-8?B?YkZ1V0FqOUM3WE9kSCtqWGhjZkFMOEtKL2UxcTV6N3lHKzJoUml2NnRFY1l2?=
 =?utf-8?B?RHF6WFY3NnVyMnJ3RFcwd3l2NWFzazFtUVp4eVZuU0M5T1VxZTZSdXdRcVZr?=
 =?utf-8?B?NDFiTDJ1blFuZmRjOHdxZzdITVhWc080MXBPVGh3eit0MldBLzJoUW1WTzB5?=
 =?utf-8?B?UXVpQkg0TWQ4YUhWMnlzY2wxdzB5OUZIU051ZEIvbnhYdllpMG9WWnVUYkVh?=
 =?utf-8?B?YU5aUmVPeFBtSnBXT2tuNHFSK0h4YVlOcmpDNVZuUkphZUgzUFBYazcwY3N3?=
 =?utf-8?Q?Ei/2PTxXAaapFnUQF/qX5cPDR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce00d7f7-949b-4e01-1575-08db4d8a1be6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 16:59:37.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m4hiqUC15tjAwqiPo+5umFbp/V/HQPV7vKXvV07x59UzbbzMxo2wE99wpWoAlOUfxCne6nJIme7SItp7VVa7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
Subject: [virtio-dev] Re: [PATCH v13 04/10] admin: introduce virtio admin virtqueues



On 5/5/2023 11:40 AM, Michael S. Tsirkin wrote:
> The admin virtqueues will be the first interface used to issue admin commands.
> 
> Currently the virtio specification defines control virtqueue to manipulate
> features and configuration of the device it operates on:
> virtio-net, virtio-scsi, etc all have existing control virtqueues. However,
> control virtqueue commands are device type specific, which makes it very
> difficult to extend for device agnostic commands.
> 
> Keeping the device-specific virtqueue separate from the admin virtqueue
> is simpler and has fewer potential problems. I don't think creating
> common infrastructure for device-specific control virtqueues across
> device types worthwhile or within the scope of this patch series.
> 
> To support this requirement in a more generic way, this patch introduces
> a new admin virtqueue interface.
> The admin virtqueue can be seen as the virtqueue analog to a transport.
> The admin queue thus does nothing device type-specific (net, scsi, etc)
> and instead focuses on transporting the admin commands.
> 
> We also support more than one admin virtqueue, for QoS and
> scalability requirements.
> 
> Based-on-patch-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

