Return-Path: <virtio-dev-return-11471-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C47C678DB
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:05:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8C3902B046
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:05:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75BFC9866CC
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:05:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6233D983E53; Tue,  7 Mar 2023 10:05:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B4D449866C2;
	Tue,  7 Mar 2023 10:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0BzbMAFVb/WSRpQgzq2nWqrDHmaFSxMG7XfPRH2JIr7D9hNBQbYLEKI/AmcaJnOolpp/Rry5QNLXmwgmG/KPhRwtgKYGFze3NAkPvQ2Xu29Tmh2frPsdsk4RfVucrxR9GbItonpDlshgSz99fWpw4QEOVZs8fs5uqrrj4Fn4noemQiUNEJg/Cb4XEi8NaYgC5oTeV73xuWVPKOtVTf42909WPZEM3cgRkamPD0oAH/6pVcMa4YT6LiajCLAJR1SGwSTVrtW0gFL6Vdni1RLqIbBMf7uxBnB2gM6CEfd2FWJSyr96756yTTX0jZ9pT2GtUEXKDlD3kVZfQFMOubCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMGXs7DQ0wsHPjMbDVRmvBuawOVk3RhC13TcYigaDWQ=;
 b=mzXSUzPzO7zIY7l+4VspVz4GUJGHfmdvJrwt6aUPcl4OaQeb5Kxr87VjET1g7f9sgNo1Wmq/j90EB0z3PAOkj4b+i+gaZ79vu48pLdhsEuTANKIermCriQR2KPD9aL1qSiGstfFQj9Mtp4O0y6Xo4mFJaZGYOlozp7uE+/ygoHFniu/FHxVx9SeF+jmC/yn/dRDns5D6VmKoMWjHIojD85EYPUhEwJ0KI3aILRKvH1jA9t1EZdoPnwPjAj9T/KwwcwK7SzXZLknEbnJ/7RiooBgrzkqDkDoUdd4Nts4q8hvUxwFR69r7mZCH+3c6OtsL4GkjL6nafT1DdCCeCi8gUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
        jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
        stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
        hang.yuan@intel.com, virtio@lists.oasis-open.org,
        Zhu Lingshan
 <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
        Shahaf Shuler
 <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
        Max Gurtovoy
 <mgurtovoy@nvidia.com>
In-Reply-To: <20230306165907-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <0a784140387c2a592f7e1e7bbc5ae926ec5b45da.1677761896.git.mst@redhat.com>
 <m2leka0yvl.fsf@oracle.com>
 <20230306165907-mutt-send-email-mst@kernel.org>
Date: Tue, 07 Mar 2023 10:04:59 +0000
Message-ID: <m2r0u0zxkk.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0283.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::18) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|SJ0PR10MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: bf31bdce-fa4b-4490-2415-08db1ef36d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TOglNJIalcTuQ8SuLORh16spFk+lH4RPoo+C+3cuxThFFzGsNyNk8TqzGwIKovHJzQyj4NoChT9cry3s9Z4dWuPZRNIhHWT94U7DD0D9EkZ41RgEXUjMGU51bkCX32skP21BJ3Hu8PnllcFG4xZyAWTOzhwLyDvMN5+EO046XajbkNpxfFJ/Vmmg/m4dX0WKEg5cPHrtdMA0lLt0kZt2VWshOoTT/rM1IQtmrGQFo6bL0Pa/SUoOc3wy3jyjCgsgM/4PqeMTAo1BiAlphK9aZduPdNOn1/b+DAEIU07O9dQNbnLsPqvgTZzil3TnqNiQvneNpau1FtNjsSujQE7H3c0P6kYBLcnu8vEtJu6lUvjh4G5dQ8X4oG6kjewnrPG7rMJz8Dpygx23zZ2fkZDZpPjKG8dp2vjU2XCZk3kCG61thjvKiwccsk8UaJa9U+/GdN/jz8aJB5PoXWHh/9GFc1g3P3jcmqV1zxI1ssYFmGOFSIoLcK9r2X02YqrWMCBnJgkfh0Fb4DaP9I62kuapvgPsTHMPXJQ28TTgkWd6yz7aXd25nAqZcwWRqunGGtuG+V/pwN7jLgvV7Tkgp15UG1DjjLNHKIv7mwK4RJO8Jq1WHL7DGeDPH7p1YCZlId1h
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199018)(66899018)(8676002)(41300700001)(66946007)(66476007)(66556008)(7416002)(5660300002)(6916009)(4326008)(8936002)(44832011)(2906002)(38100700002)(86362001)(16799955002)(36756003)(26005)(6666004)(54906003)(478600001)(6506007)(6512007)(186003)(2616005)(316002)(83380400001)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1wBP9voQmArnDr2MXr8ySCh2t9IX6bTzXFUSi0XmKMKYXhr2lJzB81p3QSW0?=
 =?us-ascii?Q?cv0QlZYlS0godqBs/BxF17QM1e9bBduqEU4xmvbhqGyPpCptul+Wc4TMNY5v?=
 =?us-ascii?Q?lZPP+gaaj2d7cIDxo0wLT9wy/Pz8qyxcwDuur8CTE2LyBLviYOkV56pHDyy/?=
 =?us-ascii?Q?4I0jkDyIXJ8n8qK3zDeRykk8wiMZ47U37qmgkIaM27M9BuhBjuZLgCOTj0/w?=
 =?us-ascii?Q?/124CNnbW8e0DpH6x/63Dc5vvSdqwtQCYbWAbCtTrX1KDbhHMcE+JTFLiPei?=
 =?us-ascii?Q?Adk5NOnKYs8X7CexGpl3uIPB7awQ1yoZKQg65hXtyUyo5sEs5KoWd2XH+Th6?=
 =?us-ascii?Q?Q68MT5J8VOtS9nQkG4mGs36o/yuXbNcUj6J0TM49n60Kl5VjModCPpt6n9wi?=
 =?us-ascii?Q?ttZhgkbNg36+fIDTQjRoi65hEgLHA/C/ts3jc7X7DVcnvnKI5eS8kvPa2FOa?=
 =?us-ascii?Q?dD7paUjjoO45TiHxs4veBqNQGRNboXoPGSoD/Dh9K90RoTcqGcr2+MtHwiCd?=
 =?us-ascii?Q?KYxaCrf+9KnsNKor5D8oXhXbtshJvG1NzL6U7mmi5ek06B3NT5XZ2twE+yEO?=
 =?us-ascii?Q?EUm1CWhbjV7CAur8T+2cUUnxWtCyO9srm8eUOYmx/alpKXzACS9JnqJvyUit?=
 =?us-ascii?Q?Pcwqpbvk3dW8/L728QkU6zRKoN/Z5NXDx4ud9qH4ljGQ3b9xz9CAJo4DHC6n?=
 =?us-ascii?Q?jhAvZ1esPANzzGYozAOgcLl3fHKqIHuba5Bwd+J00RV88lURv4Ne+UhysVpC?=
 =?us-ascii?Q?NZYTZniou/OiF3BKH/6qGOxDJHGmPfcM4UecafvDItiDy+MW0SY91qS+0miL?=
 =?us-ascii?Q?fK5NZG3crVLRzqtuTtBFZ8kVf5MngPhT+YsIUQHeQ5xa3O5++ikNhT4eiLZo?=
 =?us-ascii?Q?5yiS9J6TdHVw/Q/GREV+gG3YVT0tCoIwnqligd7hemQqE6Z89LkWHyRFXbRQ?=
 =?us-ascii?Q?c4gZmGu+qu797FI/jO2i9d70I7l1vsSkTGFpPC9khZOY+4yZJptfkhP1GHme?=
 =?us-ascii?Q?4FSD7IkwSW6EQKyLCOKoKh9Wo3yXguM6iWsg0xwonGj1x2pFqS/unH5s+weu?=
 =?us-ascii?Q?qiQwcC1OlLFpSrTazMiWoa85g1K1wxhIwLplMWfwOru4MtXbmFn0VIb/zNVn?=
 =?us-ascii?Q?7/frmgiPo8ZSUwS9xFUM5Kfzu50yGlMQkasR78k0XWrqS+70YBB9WEMHVeOA?=
 =?us-ascii?Q?iZDq05w86awooAkeKhyVN/FH7gBcZBr3VNJzFIwLGNXBNMckpGp7ems1w0zh?=
 =?us-ascii?Q?6yYwcSv7JyDp6Q+27VMjATWFy8VDvv1386KO27MBYAwx9/2sesYalOoAip73?=
 =?us-ascii?Q?HTze6Mr54cXlFhmZOH9SmEz8NAOGwY23VHGcN7jylHQWaipTYtN6ozyuZBp8?=
 =?us-ascii?Q?uWOCb5tuVYOpDAjYGZ21XMNbbd51a21WWOH0tpUa716NVBwp3XdI761IZieZ?=
 =?us-ascii?Q?naHKmDFAcocK2rESRjjPCEUF8jL9O91sCF0ErGB8e9xhj1lZLMR+e4/3CpCG?=
 =?us-ascii?Q?8yITVTeE/dH5k2i/nOI+dSsknhV0LXDveoNmelvuaq8EnZs4KszI1xFTlKZv?=
 =?us-ascii?Q?f5KA7moBZL2alaaCXdafncEEk64YFOyfFiGzL1GAL1QS+QXqzQtMlV0yrv4h?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RrNosl059kQBnbo9MByIbPBdyV2De7pX7V0Ag6CRa1Z5P0qI5ZOLUgi2s2X4HqW0/yP2+5PFf+oIMa8XiV5w5Nd39b/8IXfIBmj3PfzfmdEXn9s+nPZJn7NA4VVcG9o4EiYAlWky7TW0FWrG9yAne8RaEPq9tPeusYj1PSOwpeblAAjZnudPvOAg2ZW/D6EE53XXVETR6j3PHivsXBB0DLmJ31CWZ1Hqhna1zWOYCQo46CwkVKECNZfH0dBapJSvPsGm8oWof3OidmvOCfrfB+87rja2XLi9OTk9601+HOL0KOBYfsHOEzLlAj6m1BYtzQe5q3i12pjeJbdE7v+KMSmDuMiX/tEOokpbYS12f6oCNx8n7M9DCsVftm0eeEaabWsA2dNy5VMTXssTVqvUiLFc7jcD6Zkj1Oy3KXLWldUXCXgnvKTGpkvuESb91tioWHNm8Csh0AoIPki7agb3PrcxXXwOKc7KWZmct8TeohjDFkjVPr++KpKzNuQRjPc4Jr/zKRz8nTzi7oIT4CRuc67mf6xpdvLNZoB9f2K1uyM6MmVHQ04sE8/eLg4OFUnxPHqRuO1pkyckVMLe59JsaLRzMezN/737s2TCxK5E/yZyCm2XZ/Maba9rsqukTMWBvLuiFyoLOg7HMLtvjWjOgQM0Eh7DgxjzgY1jv+zD05b+W4pjZTapIgcy91zZfXF89Gr8dKL03VLcMH0bcJyMMUuRE+9iyEV7K7GoQEIDFgaLd7njszS+BaWVqXECNBEJmUSI//HfyuvaRXMjbH98PdoW5RnHTIytDcqRExXmW4IxlX/xv/UUXPIeDHlZtdDzCgpcbw262rjeiLy5QJSAvVhOnLWtXKEm+eHAC+CNyM2a9QtD/CovQDq7u3bqpPibg/j2hZja4pXjbkwe+W2zXA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf31bdce-fa4b-4490-2415-08db1ef36d1a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:05:06.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWUOvYaHIn7AKqg6KTLLPkCJEboeMxrvp8G7Ip537ZE7u1wrbZ8WWcLJUhIUAaW4xf3COJdWlVsvAaZ0l+uyp7Dc6fo0CVmsbgqo4i9pUoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_04,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070091
X-Proofpoint-GUID: -_K5v6ddtyPMDkz-uNt_JFfY18wIymG5
X-Proofpoint-ORIG-GUID: -_K5v6ddtyPMDkz-uNt_JFfY18wIymG5
Subject: [virtio-dev] Re: [virtio] [PATCH v10 01/10] virtio: document forward
 compatibility guarantees

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Mar 06, 2023 at 01:53:50PM +0000, David Edmondson wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > Feature negotiation forms the basis of forward compatibility
>> > guarantees of virtio but has never been properly documented.
>> > Do it now.
>> >
>> > Suggested-by: Halil Pasic <pasic@linux.ibm.com>
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > ---
>> >  content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 42 insertions(+)
>> >
>> > diff --git a/content.tex b/content.tex
>> > index 0e474dd..0c2d917 100644
>> > --- a/content.tex
>> > +++ b/content.tex
>> > @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>> >  In particular, new fields in the device configuration space are
>> >  indicated by offering a new feature bit.
>> >  
>> > +To keep the feature negotiation mechanism extensible, it is important
>> > +that devices \em{do not} offer any feature bits that they would not be
>> > +able to handle if the driver accepted them (even though drivers are not
>> > +supposed to accept them in the first place even if offered, according to
>> > +this version of the specification.) 
>> 
>> I find this (the bit in parenthesis) confusing.
>> 
>> Why are drivers not supposed to accept features that they have been
>> offered, given that they can't know that the device cannot handle the
>> feature that it just offered?
>> 
>> Is this alluding to the later section:
>> 
>> > feature bits not described in this specification, reserved feature
>> > bits and feature bits reserved or not supported for the specific
>> > transport or the specific device type
>> 
>> ?
>
> exactly. how would you put this better? given an example?

Perhaps it would be enough to say:

> (even though drivers are not supposed to accept unrecognised features in
> the first place even if offered, according to the specification)

"Unrecognised" is intended as a shorthand for the whole "not described,
reserved, ...". Maybe "unrecognised or reserved"?

>> > Likewise, it is important that
>> > +drivers \em{do not} accept feature bits they do not know how to handle
>> > +(even though devices are not supposed to offer them in the first place,
>> > +according to this version of the specification.) The preferred way for
>> > +handling reserved and unexpected features is that the driver ignores
>> > +them.
>> > +
>> > +In particular, this is
>> > +especially important for features limited to specific transports,
>> > +as enabling these for more transports in future versions of the
>> > +specification is highly likely to require changing the behaviour
>> > +from drivers and devices.
>> 
>> "require changed behaviour from drivers and devices".
>> 
>> > Drivers and devices supporting
>> > +multiple transports need to carefully maintain per-transport
>> > +lists of allowed features.
>> > +
>> >  \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
>> >  The driver MUST NOT accept a feature which the device did not offer,
>> >  and MUST NOT accept a feature which requires another feature which was
>> >  not accepted.
>> >  
>> > +The driver MUST validate the feature bits offered by the device.
>> > +The driver MUST ignore and MUST NOT accept any feature bit that is
>> > +\begin{itemize}
>> > +\item not described in this specification,
>> > +\item marked as reserved,
>> > +\item not supported for the specific transport,
>> > +\item not defined for the device type.
>> > +\end{itemize}
>> > +
>> >  The driver SHOULD go into backwards compatibility mode
>> >  if the device does not offer a feature it understands, otherwise MUST
>> >  set the FAILED \field{device status} bit and cease initialization.
>> >  
>> > +By contrast, the driver MUST NOT fail solely because a feature
>> > +it does not understand has been offered by the device.
>> > +
>> >  \devicenormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
>> >  The device MUST NOT offer a feature which requires another feature
>> >  which was not offered.  The device SHOULD accept any valid subset
>> >  of features the driver accepts, otherwise it MUST fail to set the
>> >  FEATURES_OK \field{device status} bit when the driver writes it.
>> >  
>> > +The device MUST NOT offer feature bits corresponding to features
>> > +it would not support if accepted by the driver (even if the
>> > +driver is prohibited from accepting the feature bits by the
>> > +specification); for the sake of clarity, this refers to feature
>> > +bits not described in this specification, reserved feature bits
>> > +and feature bits reserved or not supported for the specific
>> > +transport or the specific device type, but this does not preclude
>> > +devices written to a future version of this specification from
>> > +offering such feature bits should such a specification have a
>> > +provision for devices to support the corresponding features.
>> > +
>> >  If a device has successfully negotiated a set of features
>> >  at least once (by accepting the FEATURES_OK \field{device
>> >  status} bit during device initialization), then it SHOULD
>> > -- 
>> > MST
>> >
>> >
>> > ---------------------------------------------------------------------
>> > To unsubscribe from this mail list, you must leave the OASIS TC that 
>> > generates this mail.  Follow this link to all your TCs in OASIS at:
>> > https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
-- 
He caught a fleeting glimpse of a man, moving uphill pursued by a bus.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

