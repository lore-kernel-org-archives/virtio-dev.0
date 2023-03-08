Return-Path: <virtio-dev-return-11517-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B5EC678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:41:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1A05842B72
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:41:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A264986703
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:41:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EF44A9866ED; Wed,  8 Mar 2023 12:41:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB00A9866EE;
	Wed,  8 Mar 2023 12:41:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhn2itmJ5Tb0lVauIubLBNFTGV3zvqs1ft+ngOMYTa856G+7mxaw3j3VtJa1z8y5Es3PV2tVmjkvV/EbJcyJZIuL5Efo5jOzjmzwU+BOLto51n/k8EM99mtQNNsMQpHZdV4FGOM4R9hc1rdh1tPZsS+6bEgHFfbzKW5mvGCezA52nsw7Yg5dd2fZMxTo4uDA5F5puGs5oGvs6N/zaUdyl4Abr8kqsblvBtrMwxbOoa3sXBHn8oxn2CoavQtf/I/HWKc7qucG+HsgQzqGuKqkjS1HAqELJpV/nOhO1VwOXemLpbaFj7R1vAjHieyhWDDOsFSvzb+9Pbiwn924SroXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GKww2R05Ldk3zJ6K0RuZwJ+vuG+gQdAL/vEugCLObY=;
 b=lSvnShl84wrOGyh1EiVDxLsXa7XsxOPmPaSIClP7N/4iWprsmtgP823OeIRImZnWCiXz7Bi3MaLYSRX7QG4Z06h0egT1XFAb9zAwdY+yvCg2u5gAeDEXCdd/4M0YBPixbd5GXyTBpVPxQn2NGTBOPXmTLZmk95XB+Nfw3O+CuCpUVTc04SKv9eF+YtG4m97PyjXEKmwSIhb01mAQTcklJixRykAC76+nx3++rH+blgNk1ZwWd4yfUtsqIoxvuzFilevVaAgt9PDuKmxrPvIQfZ4OIVfi01Ktq/VzplqF7wyV4As/spHo2LG8kzO+6ioiC49ubEy4MfSxXM4IJ9Vsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 8 Mar 2023 13:41:37 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAiCgRLWcU1JFNWt@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
 <ZAXbBgN2jw8RhE/3@nanopsycho>
 <20230308065109-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308065109-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 324d5b3d-5e12-49ef-64bc-08db1fd27878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rYSGVB/cwOornOiQxKXGxRK1/6uCfvbujRkZeEaAmDZibqATd2DZcLxTgivblB5flplPaJAZwgqZS0XmiDTYp8QC9gVxqhPqDX3cfJI8ge4dgFD3IpdYj5x+yBTxLoRq34pQTTbvUy3/ljj5PMuveXOVxCi0ObrPkZWy0kxDa+N0aSz9csKv7FQjEkMvN51iL5i8u/tiHQedBiIv6Dni9gQ0ikDjcADcabBoF5f305D1grVz60e5yuI+q/7eQnuVQx3vs0SZaPbT131qXD0Sct3lSISxyqqJLZmOvnjKEdGGEuv74afa+sJoJsRIBitRZwjXDbqQbR/fDJzE/zUIUivhir0lo2feNmri/g4mJQSYBUwykR8TNoC61LYSsvuJnFp6ub2NGvbyxq9doBa5TTKAM1ohCbaVmHOUlJwmRH3SPCpen8L+7tmYvaqtWe8RH3mEtpTe1MbCDakSt7WacbZ5tt4EUs5xV9ORTWDg7+EcpXYGnxgNpU0YbGEx0j5mrJ7L2cHyvZ0h1FQDbQQxlPGBgT6ELkQlJiHYHjtYfYCw5046No9JCqUGPvG7Ap1NjRqd5JPXjPbyJu1StNODFYQqBdlMuDr52uu6VjajsSxon5qaoJp+rdg8dKJbENeYYkVF+uoiJ9IbtWesf4F7Ag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199018)(316002)(54906003)(83380400001)(86362001)(33716001)(2906002)(9686003)(6486002)(186003)(41300700001)(26005)(5660300002)(66556008)(66476007)(4326008)(478600001)(6666004)(6506007)(107886003)(7416002)(6512007)(8936002)(8676002)(66946007)(6916009)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zYH3zXLB9oe6j3ie4K1b/spnPDjOoZlygOKWF/EOVbRJw2cf+ZJZNp3uVR+G?=
 =?us-ascii?Q?3lIE0iSkOaIOrCF2cuiVDHOgY4Q/LdwhFgoMb7LjsC3A9+an32af4vmf16f/?=
 =?us-ascii?Q?ZYJPJBF0uDw5/V7pYYABb8yhQQJ0CVv9gYoqZefR43ivsdrUhufh7ICAHk+K?=
 =?us-ascii?Q?UjoeIoTpKRKXlVxE0zYdaxwITF2qcabTqLIxN4291eebyz5ZyPU828Em8TlC?=
 =?us-ascii?Q?KRF7cyXB2dFGP3KznqZupemEU0j6LcUraiVCaxwIcprcm4JDkDgkCOZEoSwE?=
 =?us-ascii?Q?E56Xrs9jLSBXrdUQozWJJlme+scpEFcna5BHjz6eAXVp/amGNqrERpBo5rn4?=
 =?us-ascii?Q?KKorK7qcW243esbcjZbnk9+RLhCeZtA9kygMq2TDF3HaHXj99H2an/iN7ccC?=
 =?us-ascii?Q?Q7ge8qH2eocGMd3AmEDgiDVq8vlnEBBdJ4K0L4OGtyz/RtzJ6oJZdiuao8hl?=
 =?us-ascii?Q?qDe6G1I5ZVb+o6v3gC1RK3ajtXr50IJhWm/9puXDl+DZxOsUA13tubhIz7B7?=
 =?us-ascii?Q?2qE77fkgg4eGTXYVsZisL8nFCBJboh4e9Gxz9l9pIC/X/ScpTiJ0CRZfP++P?=
 =?us-ascii?Q?29n63uck1XU/1gzJQDjJoRa0u97YKH4mn1FkyXRXcI694bOlamBJq2lxTmsz?=
 =?us-ascii?Q?WV0JQD/l1tLqke2AkG5og3JGbPiHlEHTa/qMYlmi+k6eO07V3PpAphMbfydu?=
 =?us-ascii?Q?JqvaVz0hcAeQMje7+zmoRrw8ZY+FgvJ7orCtyodhJpiJYVq7MRUcVoldL0sI?=
 =?us-ascii?Q?VW6lyc2vTjy5jaufTe+oE5MfPBcPX3pTWc3sFM3+MsUJkrwCooAlhRrLD4eF?=
 =?us-ascii?Q?Tc+ht9zUsRUr6tDGFIvzQQMNQNem9ryftD4iKAjFi9DJI+zNAkncOGwLjoNI?=
 =?us-ascii?Q?CxbHcBo6zH54xJULmwyGOPesbPaYrQz3Qph5z8GYTohn3HUkUEiEVyIisdc3?=
 =?us-ascii?Q?nUOFUW2exvLr2VRo6VeuhcE3wcuIhkR74k+Nln5wZc1/kYaTqbZd/1vY08k+?=
 =?us-ascii?Q?VRX54rgg6PBlbOmYQvczkO5OczcSdrhOCC0R9mS869uA2J8madthj3FZQQkJ?=
 =?us-ascii?Q?cCLHJuCePmi16iDu1YdNifsgwqbqtT0VIgAi3+hluxLx5keRDOPLfQ//SYjH?=
 =?us-ascii?Q?uwmEbgvcgxiFeM+jnip/ka7kSpT0iDNWOm2iH8g1htjF3YeB/JQnIRxKc75s?=
 =?us-ascii?Q?HkC8oy41/6qMmteYERXwf+TwC7NMSx4Ltfrdl3sQe/QNvGzXbNbIb3drCeNG?=
 =?us-ascii?Q?HrMDATOr8U2d+hq+oXTzKl1Abdxy/WQVG8GZgKUJWrV9RwtkyNbfgLjcRSQr?=
 =?us-ascii?Q?oKIG5wiM7Gg4XN03TghvQYSf8YwYodcTyQRzRwS6iTetAY3O2RSB1WGqy0DT?=
 =?us-ascii?Q?952hD+7zITnSw7/7zWsyMCH4xIrX2z7qdpFHzOPc9hGDoXAekZ1WoqJ4MjzD?=
 =?us-ascii?Q?b93KO3SMtAyE2O8iT+uozopJRCfYT5XntdvdxRq4YmW9aV5pf1Sb8idbgQoi?=
 =?us-ascii?Q?s/09p+LUCYibRDZ5hAP8xs8uviqHdp8/HQAaXM/E+z5eNMqc5KwX5ciJ1+UW?=
 =?us-ascii?Q?Y9cjepnLyT/3s7+uJUMnqC45I88Rxrff7+abrVrZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324d5b3d-5e12-49ef-64bc-08db1fd27878
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 12:41:42.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2NdDvB4SUfToB3Pt+e9iJPQ7Hc7/WG31a/kJKcjPgJoPqfaM3fXSo1oYwEVurQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
Subject: Re: [virtio-dev] [PATCH v10 08/10] admin: command list discovery

Wed, Mar 08, 2023 at 12:54:52PM CET, mst@redhat.com wrote:
>On Mon, Mar 06, 2023 at 01:22:30PM +0100, Jiri Pirko wrote:
>> Thu, Mar 02, 2023 at 02:05:22PM CET, mst@redhat.com wrote:
>> >Add commands to find out which commands does each group support,
>> >as well as enable their use by driver.
>> >This will be especially useful once we have multiple group types.
>> >
>> >An alternative is per-type VQs. This is possible but will
>> >require more per-transport work. Discovery through the vq
>> >helps keep things contained.
>> >
>> >Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> >Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> 
>> [...]
>> 
>> 
>> >+
>> >+The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
>> >+query the list of commands valid for this group and before sending
>> >+any commands for any member of a group.
>> >+
>> >+The driver then enables use of some of the opcodes by sending to
>> >+the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
>> >+of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
>> >+both understood and used by the driver.
>> 
>> To my untrained ear, this sounds somewhat similar to the feature
>> negotiantion mechanism. Why the fact that device/driver supports some
>> command can't be covered by just another feature? Looks like unnecassary
>> complexicity to negotiate supported commands like this.
>
>Absolutely, it is similar. The issue is that a single device can
>be an owner for multiple group types.
>For example, I think an SRIOV PF itself can have subfunctions with SIOV
>as well as virtual functions with SRIOV.
>And the set of supported commands might differ.
>
>We thus need a command that is kind of like features but per group type.

I see. But that does not mean it can't be done using existing features:

_F_SRIOV_CMD1
_F_SRIOV_CMD2
..
_F_SIOV_CMD1
_F_SIOV_CMD2
...

>
>As a small bonus as we are building this from scratch, I added
>something which was requested for a long time from features
>which is blocking access to commands not allowed by features.
>With standard virtio features we trust the driver not to send
>commands before enabling a feature and this was considered
>a maintainance/security problem.

I understand. Is it unfixable for features not to break buggy drivers?


>
>
>-- 
>MST
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

