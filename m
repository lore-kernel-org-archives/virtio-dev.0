Return-Path: <virtio-dev-return-11573-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086D0C6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:02:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 478B629FC8
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:02:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 405ED986707
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:02:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 337119866F8; Thu,  9 Mar 2023 14:02:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FCE19866F7;
	Thu,  9 Mar 2023 14:02:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyEw2R5FPT1tLqCSVFZXERr7y34Omn5BCK9IE+naJ63i+xllVsebcdiJKMPyW/NoLZafCR09zebKVA3uiTnA5xPVRlDAayI7VH7RcrqXBMErANWnlsDO7FX29Lo6neHKYSxAIdENsDjo1a/VAn0pGDpy5g+WAXT9zREbwfl7/B7rpRRD6p3CujMyXL8HcxbAuQQU4RBHFWsj39byqs5W2cFu/HaLDrr/5T/E1It7Z+1E3IAEN46sICv1/Mysu72rWhJkpC+xt/E8YNxizlA1ub5nHvLIyC/w7mECB3MOIHzZM3mNGw0gWcOfMslA35ZgR9rBXRluRvbBn6bCSiNPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDp4L/JZ0xB779tmsyRYKgIkuUJb/upcEgL+WQjcQiw=;
 b=Uv69FAG9zVZufvr2v4VQMaD38MrnnFQct8gbxwswaUh1Y72SqB484K4hTQQBEgCg6nFUtYRq8vdiQFd4uvFB/UBIHhGbWXjtx7b5qZF1s0o7ti/6bburN+zv7wzTFlGFlo+sL65GsV4sBzYscVMzS4m4Qij6spKeTJPJ/YPJkKXgIbTxB8P3zklaFKQkrkPFTUc31RCvBSuA++WrvUN6p/LSBEejeiH03JyiaHkV++jGpPSedCYfhOO7ueJPX7joOoRShzWnrWMWxwYQ2TCyy6CaB7YVVGdO1I0LMDbDOrFXiyZ0HpVcaL2T4PkDHd0pdaiy2jvg+s9juB8lDYeeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>,
        "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
        "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>,
        "jasowang@redhat.com"
 <jasowang@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "stefanha@redhat.com"
 <stefanha@redhat.com>,
        "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
        "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
        "hang.yuan@intel.com"
 <hang.yuan@intel.com>,
        "virtio@lists.oasis-open.org"
 <virtio@lists.oasis-open.org>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        Shahaf Shuler
 <shahafs@nvidia.com>
In-Reply-To: <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
 <20230308064505-mutt-send-email-mst@kernel.org>
 <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com>
 <m2wn3rxgv5.fsf@oracle.com>
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmLIc97Ud09YfGT@nanopsycho>
 <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Thu, 09 Mar 2023 14:02:30 +0000
Message-ID: <m2mt4mxbt5.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::10) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|SA1PR10MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: e42408fe-2bd0-4c9c-72bb-08db20a6efec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+SKuByWLAUzExMcEeYcH3OX87y4H0Xnt7oLPTG2jKkZm5N8jg2J3101vpknySNE6SRn+sVm7Z4Q7nJLynNqeSopzLtTEsRm/O1VuATPkzC1Dh1m2r6xAbv0a6FR8rHXAmQfY/dK02McYvRZ5NBOwRZeqDIc+Tyhh8Bla3VSfHa1MKTF3Z1PwM8PD/Ili8LrIEzdg+LmgfiP0Dl6akaDzcn2Et1GDz8BrihtU7zmZnN3TyXhuCEdRTXX3aJsZOrBlTLYeaMH4XUqTJ3RqVXx1h4/SWRUqROmJg60zgV67IX7jVTOvmEkemFrgkmW8JW1nEXLbfQww11GM5PSHRE4+EKRtwU09XLXuQ96cjdj0FL2kqSUXnMLcYTgj71PY196mzlMNIRxmUG6HznGmmYQCEf6n4J6SHHt/4a5f/Xss0Vjw4EbKjJF/K5G4FFTxcceyq+qhn599QFZ+5yvF9/Lyryd8pxEaBz6KKQTa99p4DOeAmdvftRCYW716nPMCVsmVpgooOrzKDJ9TPWfTTRc3J5sl8flaS3phBrbfENA/0PgxWfux+VcwX0EvHA9vPzl7nMmACgEAqGNMHBJourcp0HfEA1o1WfC4Lr8yhI5zY4pAxHskpG6cMkc2ZcSsNSjRASrlhGN/OUllf+x9Wb/IJA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(186003)(6486002)(36756003)(478600001)(38100700002)(54906003)(110136005)(316002)(86362001)(26005)(6506007)(6512007)(83380400001)(41300700001)(2616005)(6666004)(5660300002)(7416002)(44832011)(66556008)(8936002)(2906002)(66946007)(66476007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ImkThaz9dFwefYf2AEf92bS6H7ooJGYh5S0XUBZnPtC5Bysp51fJhAfuqCPB?=
 =?us-ascii?Q?+BA/mes8vEM3tZUb+ApskVkGASDzfx0cV/+Y4wSQ7uh7JpQYhFbIq35vYATF?=
 =?us-ascii?Q?mNWR6AIGipskFz1rBY/RdZCOr3vpvMHXSn8FNcy4UkvmwvTTs1aSuuli8Mny?=
 =?us-ascii?Q?J7DJ1X1vXRpS04QlMxY0jHjUNpTNYjfoXPMTkM+27JM/9UbKDs8AImDRZZEE?=
 =?us-ascii?Q?a2jdWfh5IZbRRF2IENlCIt8wwi+Yp1XoUXsVKqI0xoB+Su8eb/hwCWXyruiP?=
 =?us-ascii?Q?5gtCAtXIlNLMQR6A+IsZxTdUw3zOIt4ZrcraoIW1HYTWv2MaBCNrqnSuwnzx?=
 =?us-ascii?Q?ReaNgsWGzDIPnt4NnBKkkmMVZDCrEbQ9MoMXW8gX0jRMyKLwfPky9GjadWtO?=
 =?us-ascii?Q?Zw8rTBF7M2SII7YLTx8AYCSkbuj5qylLep8XNhFALHeOQZa8LxRWH+RQ5gvu?=
 =?us-ascii?Q?63frF9INitFpAnUXk6hfqFvvFmNdMUiLnsVnEaAweSVTbfM8PumQ4oU+RSFs?=
 =?us-ascii?Q?eoamAmv/uDdOc4nevs06DQ8ijhocfDF+6Y/u5YHdxiDbaHwZOdlMKpu70M62?=
 =?us-ascii?Q?TfdDJfBCnm0kEjatKhq2W6e1joeYmcOLRdHMRd1B2CgAhPrfJkjlu98gKR72?=
 =?us-ascii?Q?4A42708egL249Cmk7bg8M09jsBYTGrvQlJ0v7earIGjb6wT7ntpzR7R5yvVA?=
 =?us-ascii?Q?2zbKcGT3dp7fwdD0pxCWLQ8ubIRKFyg2MZFyOV8Ky6Mn0OAO+vHdWIodPrsw?=
 =?us-ascii?Q?IjJt6hCUZWK0VTG5YevyROLWq48KtNvXz3LJ21D67Oh9PGahaDmemu8YzLxY?=
 =?us-ascii?Q?x4z0kEa2ES2aI3jLe6QKtxKhzQk21Ld4V0L/OGJON379cTKKCxj+/f3lzeN+?=
 =?us-ascii?Q?o3zmlJ2CSN9sF6TA1et/0YXx92Czvz/H37HsIXG296LAOpCEu8asqBDNBXUf?=
 =?us-ascii?Q?NSscmlh/txaI+OpuB8VRDcn3e+RufUfeRis1Ks5K6lHENMPjB5qUOOqCcCj1?=
 =?us-ascii?Q?hUdA14IPtMoEGTcLOoWu2WRhucMsMFUF33d8/xEr9ZzULun5iZRz8eYJuUhH?=
 =?us-ascii?Q?fJTOx3ggdSCrPYX1tOtnixMwON9NK8uKSJwc3oYrl/ly5fD/wP61qQofMaM/?=
 =?us-ascii?Q?77YFgYyLZAYd8xIv7LhME249lTvwfBp99DvfrZd9g+E8/0LB/CVSmkENKp3+?=
 =?us-ascii?Q?bOMKWYhzTabt6xsVg7riBa8PGzGLoVKRuOKn5/SL6rIH4r9jtWlB1WdwT2we?=
 =?us-ascii?Q?yqpyEYr9o7tn8liwJHfBOMPbr/tD9oN2vcS0snXYA9D15O5mB4jCp7X+Mtc2?=
 =?us-ascii?Q?/1DukOH4Go+6vPNAosyDss/F2CbcFx0ZoTWAReQlQsHvo44qR0VVWC5mbgyW?=
 =?us-ascii?Q?wvSFNVE2kwVkkawFTBsf5GpQkyU6whSGm3c4/ZQYpUkwInVcTS9KudvNo1jj?=
 =?us-ascii?Q?CUC2UsKmPunnKvkOvM9KS9MJ8vGr2cDSDmueBYHCgaK4wgg/osCNfTzTHg7r?=
 =?us-ascii?Q?VTggyk4JJ+1eMktJpHWJIFjPYpR4XYi9RsSAE768NdahNdYDzwObHLgVaTQC?=
 =?us-ascii?Q?xDL2H/LisjEAQ7adKfgU1klWpJIelbOvrUL9NIeRUygUmM2euTE3tWsTqTRV?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p0ZYpKYordAHgVh4rDF/BA1HwWoAD/BF4whJRnWroRxB9vJQfY3hHB8w6WIfcheTjNduCP5vXF1R9WCywGfvqX6STyt1aeucTXAeLJDYXbnLA8+36sgsURHZfQlhQlI+GZR5NZ4dptJ98AtuUJCc9zj4qUoxNsQm9Qv414giXT3Ip6SDkqXADGk2GX6d58ZrjD/7CkhRNoJZrqd6yoexKHrqv6D5gITlwaGjg3smN0+AhC1bkh+9h/UjVdeNePtNDcU3wNte4hOv3Qi6HKOl+1zFKhwBgSWKQ5mOkmGAIobbVM8nlWZS0pM83JbAnOPzNKWknQmSl9NEPRxmCue0aRM/ebJRkRzRTQr/6fjcwtsvlgfP7rPUV0voR1raAG9D63nIaBJG3Pva5+fWlb5UDm48o2Gskj4UOfmtxYR2womxPt4vpMJqbh297AfB6u/w/4wtqrYkt8G7yfWS8rfiwxM/oo2F7a9Q0nXwuhTId3Rrg3+VIBeEGkDMKedIl6uOhFdpbZz/FQlhytFky1HnWN4fx9Ld3wNoIMa8qrHxKX3pfPXt/+soXuOh+2nwDlUlfFrOo/VJSRaOY2Yyl7jYwcso87BA7UQsx3UelfJRymoPIvTNlm7g+ipKBQHs7DV3vPdZyswasVDOfk+ah9a2yCCVS/vJpEc+DpCNHYmIfOyduf4conqL/T9aocs5RLzkd2aiPJ0t0IRzorBbgavLLRDI/nhTC1U/TK2xad/s2xjSkxZsQ/9CqV5NWatzKrp2yrItqfjRgqGOd6hygBLhxzLxoLvCjP47p84wsUhB+1s54eMMJXrLxSahu6L7HLWkya+70RSYV8ixEtv03z0CYkoXUw2qxd9gn5xCQ7p1xgDllrVLwtz4XOfE+UNjjC9px854J0VwWMdWe9DUCAYDDA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42408fe-2bd0-4c9c-72bb-08db20a6efec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 14:02:36.7623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPhskLDntJfOIt2XOI4pVvjaBGnM090oUzpMOlIzIwtgzxUbCaCBos6RuNvGH1fyKh0Xw2kEPaUwkJDkSGFL+fiyo1wR928MQUQZCYuJAns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_06,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090111
X-Proofpoint-ORIG-GUID: bv84nu29qePR9H9rGYGpO5DEyGXb2ehA
X-Proofpoint-GUID: bv84nu29qePR9H9rGYGpO5DEyGXb2ehA
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

Parav Pandit <parav@nvidia.com> writes:

>> From: Jiri Pirko <jiri@nvidia.com>
>> Sent: Thursday, March 9, 2023 2:31 AM
>> 
>> Wed, Mar 08, 2023 at 10:25:32PM CET, parav@nvidia.com wrote:
>> >
>> >> From: virtio-comment@lists.oasis-open.org
>> >> <virtio-comment@lists.oasis- open.org> On Behalf Of David Edmondson
>> >
>> >> In support of live migration, might we end up moving large amounts of
>> >> device state through the admin queue?
>> >>
>> >Correct.
>> >
>> >> If so, that would seem to have some performance requirements, though
>> >> I don't know if it would justify multiple admin queues.
>> >DMA of the data through the proposed AQ is supported.
>> >
>> >If I understood Max correctly when Max said " This AQ is not aimed for
>> >performance ", he means that AQ doesn't have performance requirements as
>> io/network queues to complete millions of ops/sec.
>> >
>> >it is several hundred to maybe (on the higher side) thousand ops/sec during
>> LM, provisioning use case.
>> 
>> But isn't it good to design it for performance from start? I mean, state transfer
>> of thousands of VFs at a time is definitelly performance related, isn't it?
>> 
> It is. Which part of the proposed AQ doesn't cover this aspect?
> The only issue that I see today is, that a given GET family of commands q contains the read-only and write-only descriptors which require multiple dma allocations on driver side.

I don't think that there is any assertion that the current proposal
doesn't cover this.

It was intended as an illustration to try and help determine whether
multiple AQs for a single device was a requirement given existing
anticipated usage, or a safeguard against potential future uses.
-- 
Up eighty flights of stairs to a basement flat.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

