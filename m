Return-Path: <virtio-dev-return-11520-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE768C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:00:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5292A4434C
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:00:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A9869866FB
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:00:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3D9339866F1; Wed,  8 Mar 2023 13:00:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E37CD9866EE;
	Wed,  8 Mar 2023 12:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djUAPVAvkqxq9ywwBh1LV8F72tCjG4oke+yLNrbyvNn11RM0G0RRoYk0VYx84cFq/CbxevalFj2OH71EtUmmBcMSq5Hvt6bRD18D/oFCv3I5y2td6D/FTPPG9dSZI5A4rMML1iYLevrdaLW8s3W6hSCb8IYxxDGbsJI/F6oo1/rL/B7yEByL5l/g4/zvffl/AnUFgZz7Diio6iB84u+2i+C0yYrPzurCj8ilCVgejMdDJMaRSDRkQSgsrBwg49+U6kwdMiQvXQbLrrp94jY2XxDOSyasWwSRHMjifYVOWnSA6OJohXkuCe9NDK1orjbEq+1PWE7xo0ez1zXHzW+n5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCPe6jPGgp2fK8jU/suA7VouA04axgikY5XqH9pf+WU=;
 b=HQwrYcqeyodBhyP82A3YspRb5m2P9dgTeglxvNzEvagaJZJ2cDdM+ujaPumaN+QgLKA6A+M/P3Z2V/blhAxgogRenLD5X0NykwjBJEG/L0h4BnMHJ1AGdBpqgBMKDaY11bd0/3n68m5O/uSnw9zvAvthF/x2IZ4tB4yvN3YmhNSKKM/apsGZBc2hJPOKQKCpvUxw650Dmy2TdfNtSlVopdnrcIMYNk2AvPwv/9nk8YEDSqfKdle1JxDZOKdxF/ouEs707iH3MTxjlAnKKAzhglchk30afqyOsXSDSJvqCTPnO2ty0ZTVNrQwWriS8Iz4AIMFQ+SRagNLo6WBIr599Q==
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
In-Reply-To: <20230308065526-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
 <m27cvszuta.fsf@oracle.com>
 <20230308065526-mutt-send-email-mst@kernel.org>
Date: Wed, 08 Mar 2023 12:59:10 +0000
Message-ID: <m24jqvz9ep.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0083.eurprd02.prod.outlook.com
 (2603:10a6:208:154::24) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CH3PR10MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 89477a9b-23dd-42bb-6dc1-08db1fd4eca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YOIYXBaiH8BGtjrpRrh02LciHrbjndAGRVKmvUSh6T+gRznveXgb8dvirkDVXWjh+gQnYtQtP3Lpz6vVgwYdFffTJ469uZQ5/p0ars94KQzAI9C452MuPMBQc5+USV0ozRNUSxW0oyM2Lss0gM5WCVqbPpkOR14OxQcuDpC1mJSspGcu5mEPiMbZypv49SOPRbA0iwg9m+muzmrhJsAPNjysvqY2vB9vVXflodz9LTkcYR4lDG+G57QvLjJKrqm8ghozZPPVM0wIuGfZ45xLtvynrrwpOL7DyVHzc8ZdNJ9fqejiiBHRHk1rn3oHLFxEVYKq9QPDTACfavbFW/oquO2P0Q+hBMHgbNOHTsa8w2eou3sOvB0X/GNLHkopAKkNgIXCXPEku6KRqfsgfpygCea3BGCTqoqRbqV9cgTxODu4XCXkq7Zd1zlWCB54gZ89WfuP6XrHDK+W607btcnPA+8eQAKc7aIYjrozhq9bVY2jujhy7EpWl5GmLUUq2yFJj24wh5sWRSUsM0Jy/8S8gQgJnpYjseqNvEGlt2FyY/B7XvDdROTEi67I8hwRHFx1m72snRJu5jFk5CYRhLYwgNyFWzZup7WkSUu6HQPHvfxMC7pgC3G7F/N45Ewr6WWedvlTuTX2qqg6W6m1h2cNYw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(6666004)(6512007)(6506007)(8936002)(44832011)(26005)(186003)(41300700001)(2616005)(83380400001)(2906002)(36756003)(7416002)(66946007)(6486002)(66556008)(5660300002)(66476007)(54906003)(316002)(478600001)(8676002)(86362001)(4326008)(6916009)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RePJ6qjyTR/Tj0g5cJTF4k2m/oG0bK9dngrAwDtIKciVWih125/hpsxgLCZL?=
 =?us-ascii?Q?0ZmRN8plINwWUJ+zC+IGBcqtZrEYpLvzq9P6wazchhBDMgP3QGjyWqaZOM13?=
 =?us-ascii?Q?DN//Hg/w8y1NNgmgnosiVUVitCrL0wrxa39PwjIAb+Uicd1iLvMCHjJEK5yS?=
 =?us-ascii?Q?qUzpsX/mZRyhJjzjoZXG/quyO+rSElLzWU0cVcFBFlSDDSxUHs2GzizRqVXC?=
 =?us-ascii?Q?KVdLLjZuDQ2rsgeRBPbW5Mv2qjr48vQWtzl2TdlAhucoNI8YnpMFhbF4e4bY?=
 =?us-ascii?Q?Zw5yBX2CjeYxrtJJnNbtHqiI42+TaDqwobmccZMkG0qu8TQRF+sb4VOM6Eab?=
 =?us-ascii?Q?kaqcy7fVPHOOsa2yq7HhAf54dAV+TeIiPbJxk/D9ubY54iZxBsunpAB2i8dD?=
 =?us-ascii?Q?BVCXUu4PYzyGwy4o+qpJ2fXT08XTOCylUZ3rZ9UMqLTKEobcj31aG+3zvlBP?=
 =?us-ascii?Q?96R+O9vL5FK+fhJbxDMetVx3K5gwgFhcscwiEqUzFV13VP5QZWpL+WDogo1R?=
 =?us-ascii?Q?3pClkFCdNnFOcosGmQnXKX7Bx6vX6EmW8v0+q5azgEWd/2S8R3TJQsCmWulw?=
 =?us-ascii?Q?oZKBm6isNTKqeT56+S4DKilh0NI4vn5hBooePpBDhwfdHe6lzj6puyb6tH4P?=
 =?us-ascii?Q?cAlJ14FuuEQWyWc4K6oDhVdC5NNUTvnE2KI9HSOJOVsBdF/IddmmxLniEbUO?=
 =?us-ascii?Q?zWgefTktAV+AWx7in9f+8Q686jvYhgKUB+HlB1wpHH7E/Yx1LpvMxB04uHOu?=
 =?us-ascii?Q?Kvl42Wt0w/CTT+RonkJp0Oh/UfG5wI03N79l3nfpm4CWsUQ1XUG3sjA8Livb?=
 =?us-ascii?Q?r3DVlws0aF7Nq3tOMiBjntK2ZYAu/4U5Ws7xzFFU5t8+QsXEm4Yq/cxoENad?=
 =?us-ascii?Q?Zw9sAVqW2nMrwcffupREPZeqZiWaL16XafVR5rORZvuSKiclsqE3bH53KGAN?=
 =?us-ascii?Q?zP3vWpFvfa6/iYK3Ix9Kmen9YOZuqnBK1mRdTbkNzQc/4hMwdqq7SitEmzdG?=
 =?us-ascii?Q?J5TdOfJiopyd2ZWfTQyndsqNfBsqvXXqHiGrxpg6TQlZcMlxHAjMcf+IcW6Y?=
 =?us-ascii?Q?RaDt0LIcsViGyvKBPvqBP8AMLtnorpL4hf5AeXQAzYaa3uvWZ/wu4WcMyWPR?=
 =?us-ascii?Q?k9hfQtZxW9Xvg/Chu/JLTkcpHrorQUHm3MO0b2wHfkjeSTkVMjXT0mf042qz?=
 =?us-ascii?Q?1NRjyrlgV7UyQl53LnTZm2d97m1EzLdLseWLAA8L3Y8D5SqYcnCjvCZrUNEm?=
 =?us-ascii?Q?72U5Tko7cZ/xqJjgvb/JQCwrQOhl5jBDpMx5MbwMpJpFHDnieJZSpuk6IIRG?=
 =?us-ascii?Q?Wovngz7iMPDWRoNUCBt8ud1Wl6KrY7Ltfsg2riDi9vfzte+jXqsaQ0LO3WIv?=
 =?us-ascii?Q?W2capfQGMOkLRS0XtrJzC4AEt4G5G0yRh46AsPQBo9Z3cpik1q/M6+7uot78?=
 =?us-ascii?Q?uCijVBqCFrczlz1dUVKIQAIGAgTtdYtHzicbjJMsJmGQM/kudz27TPPEq9ls?=
 =?us-ascii?Q?dhOSgeKAKaXvPk7xmUmK24x5JcAiiSiugBbcc/zWmqx6O5r1b/NSIbjUXDkh?=
 =?us-ascii?Q?uD8iZbu1xOYDALZsyvbrGH9I2zpTlsA99XBjWGu97ykn6eVYB5QQnc6bPMOi?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Pj/5obE9x2cBQZ1R0BKPuNoaKYmAFcOIAqIx9eoSMAClonGmDmnNlxXtZDxTbv21FZSdVxgdZI+7JWmYthHF/8/z2ZUkk99qsYwAZYuD2EO/lmLBnf0kXxeuW8FzoCmlWtNpT7IXssDmFY+8wMSvsww21WQYI79jaZBxHLNpqX23Z2wB1sXrgQ7Wo8cYpqDunreKqq8VCBQEGae7D+ozHzW/F4d6DMXH3BIbQatPjLX6Y904gxiXZIhuVV9Rc0SSRAigT1A8J6mtMgjn6KEH9jYzGZlSVhzVzNvRT9AKoIy7IB3bgRRwCRutHE21tZtYSazHVnTcRwMroptn1iWoGWZJirZn39XDRGd0fDjvhpLJkBVqQ8mvYZ6PgKpU80xu9irO07M/Lea/4f4MZnXFkLYt+kRgdpLm27wwZaFqXuDq2Czie9Dxoln4dAsabGLhxa9CEhIJeXloMf3xzAU0gbClI6TeJjLSx0uYdDaScpcCNTBZrs26n2+s1jEDnB0o6ayPUbkK9WbrGYpVb1OSakxjjhvwmwOh2rYUSgSleYRM2XDGeVNpm+q9b1epmxGAkS/0F9tDJQWfVSfatPRuDvn9v6LxqILIorjhe5uGeNad+xtJxcDrkfKiULSWd8lBTgaRjJhviKYkbA62l06KAVrRxeL+jEOSdxpYWjL0Vq5VMOQpJ3G8Su3JG+xKLCMjUaf2N2yxoTV4F75KyXcXH0y7BYdDNc74u5JxdMhKnR0ttm/bA5BLITV+LP5KD2UnNftOiZKTi/gf0ByE/BY/A6Att2Bocte0z+ZoB35tfp5habAmEHb3JTq7oFuq49RQ8p5SFYsHei26rVGrbYNbiqjkHMQOgMToRYhEIsIfUqzjYFB8nI4zo3zDJwhSUIyj6XjNLMnOXYzBDJWk5wJZdg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89477a9b-23dd-42bb-6dc1-08db1fd4eca0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 12:59:16.7459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B277+s8L9SHFiNTkUpF+3QEcLHCs+pjEXi4vrqlX0iMp1VAf5VRovaLcFLJH/fK79eirm679Y12ENm0WoBeElzYg/TqwJYbu9u1UzJEwmis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080111
X-Proofpoint-GUID: H3zTWG1pvGJxYSJxLgmpgiHzFyo6hzbW
X-Proofpoint-ORIG-GUID: H3zTWG1pvGJxYSJxLgmpgiHzFyo6hzbW
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 09/10] admin: conformance clauses

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Mar 07, 2023 at 11:04:33AM +0000, David Edmondson wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
>> > +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
>> > +with respective bits cleared in \field{command_specific_data}.
>> 
>> This runs contrary to the assertion "The list of supported commands MUST
>> NOT shrink", given that a driver is told to assume that
>> VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE are the only
>> commands initially available.
>
> Commands are still available just disabled, the meaning of
> "MUST NOT shrink" is clarified by the following:
>
> 	> > +after reporting a given command as supported through
> 	> > +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
> 	> > +as unsupported.
> I will stick an "i.e." there to make it hopefully clearer.

This puzzles me.

I can see the point of blocking LIST_USE, but not of blocking
LIST_QUERY. What's the purpose of this?
-- 
Time is waiting to explain, why refuse?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

